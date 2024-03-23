{
  description = "Nix shell";
  nixConfig.bash-prompt = "\\e[0;32m\[🚀 nix-shell\] \$PWD$ \\e[m ";

  inputs = {
    nixpkgs = {
      type = "tarball";
      url = "https://git.beyond.cc/public/nixpkgs/archive/master.tar.gz";
    };
    flake-utils = {
      type = "git";
      url = "https://git.beyond.cc/public/flake-utils.git";
    };
    flake-compat = {
      type = "git";
      url = "https://git.beyond.cc/public/flake-compat.git";
      flake = false;
    };
    # pulsar = {
    #   url = "https://archive.apache.org/dist/pulsar/pulsar-3.0.3/apache-pulsar-3.0.3-bin.tar.gz";
    #   flake = false;
    # };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:    
    let
      forSystem = system:
        let
          config = { packageOverrides = p: {
            sbt = p.sbt.override {
              jre = p.jdk17;
            };
            gradle = p.gradle.override {
              java = p.jdk17;
            };
            yarn = p.yarn.override {
              nodejs = p.nodejs-16_x;
            };
            };};
            pkgs = import nixpkgs {
              inherit system;
              inherit config;
            };
        in
        {
          devShells.default = pkgs.mkShell {
            name = "nix-shell";
            buildInputs = with pkgs; [              

              jdk17
              gradle

              python3
              python310Packages.pip

              curl
              git
              pwgen
              jq
              ripgrep
              vim

            ];

            shellHook = ''
              set +e
              # export PATH=$PATH:$PULSAR_HOME/bin
              export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib/"
              echo "Welcome to nix shell"

            '';
          };
        };
    in
    flake-utils.lib.eachDefaultSystem forSystem;
}
