# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
imports =
	[ # Include the results of the hardware scan.
	./hardware-configuration.nix
	inputs.home-manager.nixosModules.default
];

# Use the systemd-boot EFI boot loader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

# AppImages
boot.binfmt.registrations.appimage = {
  wrapInterpreterInShell = false;
  interpreter = "${pkgs.appimage-run}/bin/appimage-run";
  recognitionType = "magic";
  offset = 0;
  mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
  magicOrExtension = ''\x7fELF....AI\x02'';
};

networking.hostName = "Gartroc"; # Define your hostname.
# Pick only one of the below networking options.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.


# Flakes.
nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Set your time zone.
time.timeZone = "Europe/Berlin";

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
i18n.defaultLocale = "de_DE.UTF-8";
console = {
font = "Lat2-Terminus16";
keyMap = "de";
# useXkbConfig = true; # use xkb.options in tty.
};

# Enable the Hyprland windowing system.
programs.hyprland.enable = true;
xdg.portal.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

# Steam
programs.steam.enable = true;
# Zsh
programs.zsh.enable = true;

# Enable CUPS to print documents.
services.printing.enable = true;

# Enable sound.
sound.enable = true;
security.rtkit.enable = true;
services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
	jack.enable = true;
};

# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.andi = {
	isNormalUser = true;
	extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
	description = "Andreas Thurau";
	initialPassword = "password";
	shell = pkgs.zsh;
};

home-manager = {
	extraSpecialArgs = { inherit inputs; };
	users = {
		"andi" = import ./home.nix;
	};
};
# List packages installed in system profile. To search, run:
# $ nix search wget
environment.systemPackages = with pkgs; [
	home-manager
	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	wget
	waybar
	(waybar.overrideAttrs (oldAttrs: {
		mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
		})
	)
	networkmanagerapplet
	dunst
	libnotify
	swww
	kitty
	rofi-wayland
	firefox
	zsh
	zsh-syntax-highlighting
	autojump
	zsh
	zsh-autosuggestions
	zoxide
	git
	steam
	discord
	betterdiscord-installer
	betterdiscordctl
	whatsapp-for-linux
	element-desktop
	audacity
	prismlauncher
	appimage-run
	grim
	slurp
	wf-recorder
	mpv
	lutris
	wine
	winetricks
	bottles
	gthumb
	pinta
	dolphin
	zip
	ryujinx
	libreoffice
];

# Allow unfree software
nixpkgs.config.allowUnfree = true;

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
programs.mtr.enable = true;
programs.gnupg.agent = {
	enable = true;
	enableSSHSupport = true;
};

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
#
# Most users should NEVER change this value after the initial install, for any reason,
# even if you've upgraded your system to a new NixOS release.
#
# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
# so changing it will NOT upgrade your system.
#
# This value being lower than the current NixOS release does NOT mean your system is
# out of date, out of support, or vulnerable.
#
# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
# and migrated your data accordingly.
#
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
system.stateVersion = "23.11"; # Did you read the comment?

}

