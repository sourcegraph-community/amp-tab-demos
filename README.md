# Amp Tab Demos

This repository contains demo videos comparing Amp Tab vs Cursor Tab functionality across different use cases.

## Repository Structure

```
amp-tab-demos/
├── demos/
│   ├── delete-interface-fields/     # Demonstration of deletion and long-range edits
│   │   ├── README.md               # Demo-specific instructions  
│   │   ├── amp_tab.mp4            # Amp Tab demonstration (source)
│   │   ├── cursor_tab.mp4         # Cursor Tab demonstration (source)
│   │   ├── amp_tab_2.0x.gif       # Amp Tab GIF (for README display)
│   │   └── cursor_tab_2.0x.gif    # Cursor Tab GIF (for README display)
│   └── [future-demo-folders]/      # Additional demo cases
├── convert-to-gif.sh               # Script to convert MP4s to optimized GIFs
└── README.md                       # This file
```

## Setup

This repository uses Git LFS for large video and GIF files.

**Prerequisites:**
```bash
# Install Git LFS (required for cloning large files)
brew install git-lfs
git lfs install

# Install ffmpeg and bc (for GIF conversion)
brew install ffmpeg bc
```

**Cloning the repository:**
```bash
git clone https://github.com/sourcegraph-community/amp-tab-demos.git
cd amp-tab-demos
git lfs pull  # Downloads the actual video/GIF files
```

## Converting Videos to GIFs (for README display)

**Usage:**
```bash
# Navigate to any demo folder
cd demos/delete-interface-fields/

# Convert with default settings (2x speed, 1920px width)
../../convert-to-gif.sh amp_tab.mp4
../../convert-to-gif.sh cursor_tab.mp4

# Custom speed and width
../../convert-to-gif.sh amp_tab.mp4 1.5 1280
```

**Script Features:**
- Configurable playback speed
- Adjustable output width
- Optimized palette generation for smaller file sizes
- File size comparison output

## Adding New Demos

1. Create a new folder under `demos/` with a descriptive name
2. Add your demo videos (preferably named `amp_tab.mp4` and `cursor_tab.mp4`)
3. Create a `README.md` with:
   - Tags describing the demo intent
   - Reproduction steps
   - Links to demo videos

## Demo Tags

Use these tags to categorize demos:
- `deletion` - Variable/code deletion scenarios
- `long-range-edits` - Multi-line or cross-file editing
- `completion` - Code completion scenarios
- `refactoring` - Code restructuring
- `debugging` - Error fixing and debugging
