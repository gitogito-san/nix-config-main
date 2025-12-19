{ pkgs, ... }:

let
  targetIconName = "cross";
  variantName = "Nordzy-Gapped-Precision";
  sourcePkg = pkgs.nordzy-cursor-theme;
  baseTheme = "Nordzy-catppuccin-frappe-light";

  stableReticleTheme = pkgs.runCommand "nordzy-stable-reticle-v2" { } ''
        ICON_DIR=$out/share/icons/${variantName}
        mkdir -p $ICON_DIR/cursors

        SOURCE_BIN="${sourcePkg}/share/icons/${baseTheme}/cursors/${targetIconName}"
        if [ ! -f "$SOURCE_BIN" ]; then
            echo "Error: Source icon ${targetIconName} not found!"
            exit 1
        fi

        for name in default left_ptr right_ptr hand1 hand2 xterm text cross \
                    pointer wait progress help alias copy move no-drop not-allowed \
                    all-scroll col-resize row-resize plus; do
          cp "$SOURCE_BIN" $ICON_DIR/cursors/$name
        done

        cat <<EOF > $ICON_DIR/index.theme
    [Icon Theme]
    Name=${variantName}
    Comment=Gapped Crosshair Precision Theme
    Inherits=${baseTheme},Adwaita
    EOF
  '';
in

{
  home.pointerCursor = {
    package = stableReticleTheme;
    name = variantName;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  wayland.windowManager.hyprland.settings.env = [
    "XCURSOR_THEME,${variantName}"
    "XCURSOR_SIZE,22"
    "HYPRCURSOR_THEME,${variantName}"
    "HYPRCURSOR_SIZE,22"
  ];
}
