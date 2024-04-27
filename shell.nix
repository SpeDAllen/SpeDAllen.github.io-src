{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell
  {
    packages = [
      (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.pelican
        python-pkgs.ghp-import
      ]))
      pkgs.emacs
      pkgs.emacsPackages.htmlize
      pkgs.emacsPackages.nix-mode
    ];
    # shellHook = ''
    #   echo ORG_READER_EMACS_LOCATION = \'${pkgs.emacs}/bin/emacs\' >> ./pelicanconf.py
    # '';
  }
