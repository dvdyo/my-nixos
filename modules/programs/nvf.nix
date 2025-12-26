{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.programs.nvf;
in
{
  imports = [
    inputs.nvf.nixosModules.default
  ];

  options.custom.programs.nvf.enable = lib.mkEnableOption "Enable nvf (Neovim configuration)";

  config = lib.mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;
          preventJunkFiles = true;
          useSystemClipboard = true;

          # Basic formatting/indentation
          tabWidth = 4;

          # Theme
          theme = {
            enable = true;
            name = "gruvbox";
            style = "dark";
          };

          # UI
          statusline.lualine.enable = true;
          telescope.enable = true;
          autocomplete.nvim-cmp.enable = true;
          filetree.nvim-tree.enable = true;
          tabline.nvimBufferline.enable = true;
          treesitter.enable = true;

          # Debugging
          debugger = {
            nvim-dap = {
              enable = true;
              ui.enable = true;
            };
          };

          # Language support
          lsp = {
            enable = true;
            formatOnSave = true;
            lightbulb.enable = true;
          };

          languages = {
            enableLSP = true;
            enableTreesitter = true;
            enableFormat = true;

            nix.enable = true;
            markdown.enable = true;
            bash.enable = true;
            python.enable = true;
          };

          # Assistant
          assistant.copilot.enable = false; # Example
        };
      };
    };
  };
}
