# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
##
## Welcome to the GearOS specific config file!
## This includes a number of packages that aid in programming and video editing.
## Additionally, there are TWO options for Desktop Environments.
## The default comments generated by NixOS have been left intact, for your convienence.
## My additions will be marked with ##, instead of just #

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  ## The following lines are for testing in a VM. Enable only if needed.
  virtualisation.virtualbox.guest.enable = true;
  boot.initrd.checkJournalingFS = false;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  ## These next three lines are for EFI enabled systems ONLY.
  ## Do not uncomment on Legacy systems. It'll break everything.
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  ## By default, this should be /dev/sda, but DOUBLE CHECK.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "gearos"; # Define your hostname.
  ## Comment the following line out on systems that will only be connected via Ethernet.
  ## networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Americas/Chicago";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
  wget
  android-studio
  firefox
  chromium
  ecj
  eclipses.eclipse-sdk
  n2048 
  kdeApplications.kdenlive
  git-hub
  vim
  emacs
  nano
  sudo
  ranger
  w3m
  jdk7 ## Technically, both JDK7 and JDK8 are untested.
  jdk  ## They both shouldn't cause issues, though.
       ## I will still push to Untested just to keep things consistent.
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  ## Enable the XFCE Desktop Environment (For weaker computers)
  ## Remember to comment out the lines relating to KDE and SDDM.
  ## services.xserver.desktopManager = {
  ##	xfce.enable = true;
  ##	default = "xfce";
  ## };
  ## services.xserver.displayManager.slim.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  ## No, seriously, this needs to be set on first boot.
  users.extraUsers.gearuser = 
  {  isNormalUser = true;
     home = "/home/gearuser";
     description = "Normal user account";
     extraGroups = [ "wheel" "networkmanager" ]; 
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
