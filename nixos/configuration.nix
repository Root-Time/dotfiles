# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, modulesPath,... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

   # services.xserver.videoDrivers = [ "nvidia" ];
   # hardware.opengl = {
     # enable = true;
     # driSupport = true;
     # driSupport32Bit = true;
   # };
  #  hardware.nvidia = {
  #    modesetting.enable = true;
  #    open = true;
  #    powerManagement.enable = false;
  #    powerManagement.finegrained = false;
  #    nvidiaSettings = false;
  #    package = config.boot.kernelPackages.nvidiaPackages.beta;
  #  };

  # services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  
  boot = {
    initrd = {
      kernelModules = [ "nvidia" ];
    };
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  };
  
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
  
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      #package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
      setLdLibraryPath = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      # package = let 
      # rcu_patch = pkgs.fetchpatch {
         # url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
    #      hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
    #    };
       #in config.boot.kernelPackages.nvidiaPackages.mkDriver {
     	#version = "535.154.05";
     	#sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
     	#sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
    	#openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
    	#settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
    	#persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";
  
     	#version = "550.40.07";
     	#sha256_64bit = "sha256-KYk2xye37v7ZW7h+uNJM/u8fNf7KyGTZjiaU03dJpK0=";
     	#sha256_aarch64 = "sha256-AV7KgRXYaQGBFl7zuRcfnTGr8rS5n13nGUIe3mJTXb4=";
     	#openSha256 = "sha256-mRUTEWVsbjq+psVe+kAT6MjyZuLkG2yRDxCMvDJRL1I=";
     	#settingsSha256 = "sha256-c30AQa4g4a1EHmaEu1yc05oqY01y+IusbBuq+P6rMCs=";
      	#persistencedSha256 = "sha256-11tLSY8uUIl4X/roNnxf5yS2PQvHvoNjnd2CB67e870=";
  
         #patches = [ rcu_patch ];
      #};
       # forceFullCompositionPipeline = true;
       # powerManagement.enable = false;
    };
  };
  #
   services = {
     xserver = {
       enable = true;
       layout = "us";
       xkbVariant = "";
       excludePackages = [ pkgs.xterm ];
       videoDrivers = ["nvidia"];
       libinput.enable = true;
       displayManager.sddm = {
         enable = true;
         # wayland = true;
       };
     };
     dbus.enable = true;
     gvfs.enable = true;
     tumbler.enable = true;
       gnome = {
       sushi.enable = true;
       gnome-keyring.enable = true;
     };
   };


  
  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
  };
 

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.

  # Enable the KDE Plasma Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11

  # Configure console keymap
  console.keyMap = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.fish;
  users.users.time = {
    isNormalUser = true;
    useDefaultShell = true;
    description = "Time Root";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kate
    #  thunderbird
    ];
  };

  programs.fish.enable = true;


  # Install firefox.
  programs.firefox.enable = true;
  programs.direnv.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  
  environment.systemPackages = with pkgs; [
    inputs.neovim.packages.${pkgs.system}.neovim
    emacs
    #neovim
    xwaylandvideobridge
    wget
    fish
    imagemagick
    floorp
    steam
    nix-prefetch-github
    # mako
    cargo-leptos
    cargo-generate
    lld
    eza
    egl-wayland
    lunar-client
    spotify
    scrcpy
    android-tools
    libuuid
    nodePackages.dotenv-cli
    fzf
    openssl
    nodePackages.ts-node
    ripgrep
    bat
    nnn
    zoxide
    prisma-engines
    nodePackages.prisma
    wlogout
    gtklock
    screen
    corepack
    unzip
    zip
    gnumake
    sway
    neofetch
    trunk
    leptosfmt
    cargo-leptos
    btop
    glxinfo
    killall
    gcc
    grim
    swappy
    libgcc
    vivaldi
    wl-clipboard
     
    nvidia-vaapi-driver
    libva-utils
    libva
    wl-clipboard
    hyprpicker


    slurp
    swaynotificationcenter
    prismlauncher
    termius
    kitty
    rofi-wayland
    git
    anyrun
    waybar
    vscode
    nodejs
    tree-sitter
    rustup
    swww
    blueman
    networkmanagerapplet
    chezmoi
    vesktop
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    cliphist
    pavucontrol
  ];

  environment = {
    sessionVariables = {
      # LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [pkgs.libuuid]}";
    };
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}


