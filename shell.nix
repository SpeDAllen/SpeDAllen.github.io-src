{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell
  {
    packages = with pkgs; [
      (python3.withPackages (python-pkgs: [
        python-pkgs.pelican
        python-pkgs.ghp-import
      ]))
      ((emacsPackagesFor pkgs.emacs29-pgtk).emacsWithPackages (
        epkgs: [
          epkgs.htmlize
          epkgs.nix-mode
          epkgs.use-package
          epkgs.nerd-icons
          epkgs.evil-nerd-commenter
          epkgs.doom-modeline
          epkgs.all-the-icons
          epkgs.doom-themes
          epkgs.rainbow-delimiters
          epkgs.org
          epkgs.org-bullets
          epkgs.visual-fill-column
          epkgs.string-inflection
        ]
      ))
      emacs-all-the-icons-fonts
      dejavu_fonts
      hunspell
      hunspellDicts.en_US-large
    ];
    shellHook = ''
      # echo ORG_READER_EMACS_LOCATION = \'${pkgs.emacs29-pgtk}/bin/emacs\' >> ./pelicanconf.py
      # echo ORG_READER_EMACS_SETTINGS = \'./.emacs\' >> ./pelicanconf.py
      emacs -q -l ./.emacs &
      make devserver
    '';
    DICPATH = "${pkgs.hunspellDicts.en_US-large}/share/hunspell/";
  }
