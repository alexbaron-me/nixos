# Various TUI tools
{pkgs, ...}: {
  home-manager.users.albarn = {
    programs.btop = {
      enable = true;
    };

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        show_hidden = true;
        show_symlink = true;
        scrolloff = 4;
        preview = {
          tab_size = 2;
          image_delay = 150;
        };
      };
      keymap = {
        manager.prepend_keymap = [
          {
            on = "!";
            run = "shell '$SHELL' --block --confirm";
            desc = "Open shell here";
          }
          {
            on = "<C-n>";
            run = "shell '${pkgs.dragon}/bin/dragon -x -i -T \"$1\"' --confirm";
          }
          {
            on = ["g" "r"];
            run = "shell 'ya pub dds-cd --str \"$(git rev-parse --show-toplevel)\"' --confirm";
            desc = "Return to Git Repo Root";
          }
        ];
      };
      initLua = ''
        -- Show username and host in header
        Header:children_add(function()
        	if ya.target_family() ~= "unix" then
        		return ui.Line {}
        	end
        	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
        end, 500, Header.LEFT)

        -- Show group and owner in status bar
        Status:children_add(function()
        	local h = cx.active.current.hovered
        	if h == nil or ya.target_family() ~= "unix" then
        		return ui.Line {}
        	end

        	return ui.Line {
        		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
        		ui.Span(":"),
        		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
        		ui.Span(" "),
        	}
        end, 500, Status.RIGHT)
      '';
    };
  };
}
