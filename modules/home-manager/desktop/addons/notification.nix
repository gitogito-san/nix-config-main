{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      notification-2fa-action = true;
      notification-inline-replies = true;
      timeout = 8;
      timeout-low = 4;
      timeout-critical = 0;
      fit-to-screen = true;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
    };

    style = ''
      .notification-row {
        outline: none;
      }
      .notification-row:focus,
      .notification-row:hover {
        background: #3b4252;
      }
      .notification {
        border-radius: 12px;
        margin: 6px 12px;
        box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.3), 0 1px 3px 1px rgba(0, 0, 0, 0.07),
          0 2px 6px 2px rgba(0, 0, 0, 0.03);
        padding: 0;
      }
      .summary {
        font-size: 16px;
        font-weight: bold;
        color: #eceff4;
      }
      .body {
        font-size: 14px;
        color: #e5e9f0;
      }
      .control-center {
        background: #2e3440;
        border-radius: 12px;
        border: 1px solid #4c566a;
        box-shadow: 0 4px 60px 0 rgba(0, 0, 0, 0.5);
      }
      .close-button {
        border-radius: 50%;
        background: #bf616a;
        color: #eceff4;
        border: none;
      }
    '';
  };
}
