{
  lib,
  pkgs,
  ...
}: let
  scriptPackages = with pkgs; [
    satty
    grim
    slurp # Used for region selection
    wl-clipboard # Used for wl-copy
    jq # Used for niri message parsing
    niri # Used for focused-output detection
  ];

  sattyScript = ''
    # Find the focused output, falling back to an empty string if niri or jq fail
    focused_output=$(niri msg --json focused-output 2>/dev/null | jq -r '.name' 2>/dev/null || echo "")

    # Create a temporary file and ensure it is cleaned up on exit
    temp_file=$(mktemp --suffix=".png")
    trap 'rm -f "$temp_file"' EXIT

    # Take the screenshot
    if [ -n "$focused_output" ]; then
        # Try to capture the focused output
        if ! grim -o "$focused_output" "$temp_file"; then
            echo "Failed to take screenshot of focused output $focused_output" >&2
            exit 1
        fi
    else
        # Fallback to a full-screen screenshot
        if ! grim "$temp_file"; then
            echo "Failed to take a full screenshot" >&2
            exit 1
        fi
    fi

    # Define the output filename with the date
    temp_date=$(date +'%Y%m%d_%H%M%S')
    output_path="$HOME/Pictures/Screenshots/$temp_date.png"

    # Open the screenshot with Satty for editing
    satty \
      --filename "$temp_file" \
      --output-filename "$output_path" \
      --save-after-copy \
      --copy-command "wl-copy" \
      --actions-on-escape save-to-file \
      --early-exit
  '';

  sattyScriptRegion = ''
    temp_date=$(date +'%Y%m%d_%H%M%S')
    output_path="$HOME/Pictures/Screenshots/$temp_date.png"

    # Use grim/slurp to capture a region and pipe the PPM output to satty
    grim -g "$(slurp)" -t ppm - | satty \
      --filename - \
      --output-filename "$output_path" \
      --save-after-copy \
      --copy-command "wl-copy" \
      --actions-on-escape save-to-file \
      --early-exit
  '';

  mkSattyScript = name: text:
    pkgs.writeShellApplication {
      inherit name text;
      runtimeInputs = scriptPackages;
    };

  sattyScreenshot = mkSattyScript "satty-screenshot" sattyScript;
  sattyScreenshotRegion = mkSattyScript "satty-screenshot-region" sattyScriptRegion;
in {
  home.persistence."/persist" = {
    directories = [
      ".cache/satty"
      "Pictures/Screenshots"
    ];
  };

  home.packages = [
    pkgs.satty
    sattyScreenshot
    sattyScreenshotRegion
  ];
}
