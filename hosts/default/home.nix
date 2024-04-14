{ config, pkgs, ... }:

{
home.username = "andi";
home.homeDirectory = "/home/andi";

# Don't change
home.stateVersion = "23.11";


home.packages = [
	pkgs.hello

];

home.file = {
#	programs.zsh = {
#		enable = true;
#	};		
};

home.sessionVariables = {
    # EDITOR = "emacs";
 };



# Let Home Manager install and manage itself.
programs.home-manager.enable = true;
}
