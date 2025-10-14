{
  description = "Computer Vision Project Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Python with pip and venv support
            python311
            python311Packages.pip
            python311Packages.virtualenv
            
            # Development tools
            git
            
            # Common CV libraries (optional, can be installed via pip in venv)
            # Uncomment if needed at system level:
            # libGL
            # glib
            # zlib
          ];

          shellHook = ''
            echo "🚀 Computer Vision Development Environment"
            echo "==========================================="
            echo ""
            
            # Create virtual environment if it doesn't exist
            if [ ! -d ".venv" ]; then
              echo "📦 Creating Python virtual environment..."
              python -m venv .venv
              echo "✅ Virtual environment created"
              echo ""
            fi
            
            # Activate virtual environment
            echo "🔧 Activating virtual environment..."
            source .venv/bin/activate
            echo "✅ Virtual environment activated"
            echo ""
            
            echo "Python version: $(python --version)"
            echo "Virtual environment: $VIRTUAL_ENV"
            echo ""
            
            # Check if requirements.txt exists and offer to install
            if [ -f "requirements.txt" ]; then
              echo "📋 Found requirements.txt"
              echo "To install dependencies, run:"
              echo "  pip install -r requirements.txt"
              echo ""
            fi
            
            echo "To install packages directly:"
            echo "  pip install <package-name>"
            echo ""
            echo "To exit the environment:"
            echo "  exit (or Ctrl+D)"
            echo ""
            echo "==========================================="
          '';

          # Set environment variables for better compatibility
          LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
        };
      }
    );
}
