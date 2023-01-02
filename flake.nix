{
  description = "Nix shell";
  nixConfig.bash-prompt = "\\e[0;32m\[🚀 nix-shell\] \$PWD$ \\e[m ";

  inputs = {
    nixpkgs = {
      type = "gitlab";
      owner = "opensource";
      repo = "nixpkgs";
      host = "gitlab.beyond.cc";
    };
    flake-utils = {
      type = "gitlab";
      owner = "opensource";
      repo = "flake-utils";
      host = "gitlab.beyond.cc";
    };
    flake-compat = {
      type = "gitlab";
      owner = "opensource";
      repo = "flake-compat";
      host = "gitlab.beyond.cc";
      flake = false;
    };
    pulsar = {
      url = "https://dlcdn.apache.org/pulsar/pulsar-2.10.2/apache-pulsar-2.10.2-bin.tar.gz";
      flake = false;
    };
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
              # export PATH=$PATH:$HOME/apache-pulsar-2.10.2/bin
              echo "Welcome to nix shell"

            '';
          };
        };
    in
    flake-utils.lib.eachDefaultSystem forSystem;
}
