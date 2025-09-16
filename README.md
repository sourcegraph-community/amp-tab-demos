# Amp Tab AI Completion Demos

See how Amp Tab's advanced AI completion compares with other tools across real-world coding scenarios.

## 🎬 **[View Comparisons →](https://sourcegraph-community.github.io/amp-tab-demos/)**

**Click the link above to see side-by-side video comparisons.**

---

## ✨ Features

- **Side-by-side comparisons** - Watch Amp Tab vs competitors simultaneously  
- **Independent controls** - Each video has its own playback controls
- **Mobile responsive** - Perfect viewing on any device
- **Zero dependencies** - Just HTML + JavaScript, no servers needed

## 📁 Repository Structure

```
amp-tab-demos/
├── index.html                    # 🎬 Main comparison page (186 lines, demos embedded)
├── demos/                       # 📁 Video files
│   ├── delete-interface-fields/
│   │   ├── README.md           # Demo details & reproduction steps
│   │   ├── amp_tab.mp4         # Amp Tab demo
│   │   └── cursor_tab.mp4      # Competitor demo
│   └── delete-proxy-variable/
│       ├── README.md           # Demo details & reproduction steps
│       ├── amp_tab.mp4
│       └── cursor_tab.mp4
├── .github/workflows/pages.yml  # Auto-deploy to GitHub Pages
├── .gitattributes              # Git attributes (no LFS)
├── .gitignore                  # Standard ignore rules
├── LICENSE                     # MIT License
└── README.md                   # This file
```

## ➕ Adding New Demos

1. **Add videos** to a new folder in `demos/`
2. **Update the `DEMOS_DATA` object** in `index.html`:
   ```javascript
   {
     "id": "new-demo",
     "title": "My New Demo", 
     "description": "Description of what this demo shows...",
     "tags": ["completion", "refactoring"],
     "videos": {
       "amp": "demos/new-demo/amp_tab.mp4",
       "cursor": "demos/new-demo/cursor_tab.mp4"
     }
   }
   ```
3. **Commit and push** - GitHub Pages will auto-deploy!

## 🏗️ Extending Beyond Cursor Tab

To add more competitors (VS Code, GitHub Copilot, etc.):

1. **Add video paths** to the `DEMOS_DATA` object in `index.html`:
   ```javascript
   "videos": {
     "amp": "demos/demo-name/amp_tab.mp4",
     "cursor": "demos/demo-name/cursor_tab.mp4", 
     "copilot": "demos/demo-name/github_copilot.mp4"
   }
   ```

2. **Update the HTML template** in `index.html` to render additional video containers.

The system is designed to be easily extensible for any number of AI completion tools.
