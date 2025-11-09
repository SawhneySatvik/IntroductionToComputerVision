# Computer Vision Project - Nix Development Environment

This project uses Nix Flakes to provide a reproducible development environment with Python and virtual environment support.

## Prerequisites

1. **Install Nix** (if not already installed):
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```

2. **Enable Nix Flakes** (if not already enabled):
   - The Determinate Nix installer enables flakes by default
   - If using the official Nix installer, add to `~/.config/nix/nix.conf`:
     ```
     experimental-features = nix-command flakes
     ```

## Getting Started

### 1. Enter the Nix Development Shell

```bash
nix develop
```

This will automatically:
- Download and set up Python 3.11
- Create a Python virtual environment (`.venv`) if it doesn't exist
- Activate the virtual environment
- Display helpful instructions

### 2. Install Dependencies

**Option A: From requirements.txt**
```bash
pip install -r requirements.txt
```

**Option B: Install packages individually**
```bash
pip install opencv-python numpy pillow
```

**Option C: Install deep learning frameworks**
```bash
# For PyTorch
pip install torch torchvision

# For TensorFlow
pip install tensorflow
```

## Project Structure

```
.
├── flake.nix          # Nix flake configuration
├── .gitignore         # Git ignore patterns
├── requirements.txt   # Python dependencies
├── README.md          # This file
└── .venv/            # Python virtual environment (created by you)
```

## Common Workflows

### Daily Development

```bash
# Enter Nix shell (automatically creates and activates venv)
nix develop

# Work on your project...
# The virtual environment is already activated!

# Exit when done (this also deactivates the venv)
exit
```

### Installing New Packages

```bash
# The venv is already activated when you run 'nix develop'
# Just install packages directly:
pip install <package-name>

# Update requirements.txt
pip freeze > requirements.txt
```

### Updating Dependencies

```bash
# Update all packages
pip install --upgrade -r requirements.txt

# Update specific package
pip install --upgrade <package-name>
```

## Customizing the Environment

### Adding System Packages

Edit `flake.nix` and add packages to the `buildInputs` list:

```nix
buildInputs = with pkgs; [
  python311
  python311Packages.pip
  # Add more packages here
  ffmpeg
  imagemagick
];
```

### Changing Python Version

In `flake.nix`, replace `python311` with your desired version:
- `python39` for Python 3.9
- `python310` for Python 3.10
- `python312` for Python 3.12

## Troubleshooting

### "command not found: nix"
- Make sure Nix is installed and your shell has been restarted

### "error: experimental Nix feature 'flakes' is disabled"
- Enable flakes in your Nix configuration (see Prerequisites)

### Virtual environment not activating automatically
- The Nix shell automatically creates and activates the venv
- If you see issues, try deleting `.venv` and run `nix develop` again
- Check that the shellHook in `flake.nix` is properly configured

### Import errors after installing packages
- Ensure the virtual environment is activated
- Verify the package is installed: `pip list`

## Tips

- The virtual environment is automatically activated when you run `nix develop`
- Keep `requirements.txt` updated for reproducibility
- Use `pip freeze > requirements.txt` to capture exact versions
- The `.gitignore` file excludes the `.venv` directory from Git

## Next Steps

1. Create your Python scripts in the project directory
2. Import your dependencies
3. Build your computer vision project!

Happy coding! 🚀
