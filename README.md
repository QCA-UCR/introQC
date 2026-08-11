## Build locally

```bash
make build      # writes docs/
make serve      # preview at http://localhost:8000
make test       # run build verification
```

## Deploy

Push to `main`. The GitHub Action installs Pandoc, runs `make build`, and publishes `docs/` to GitHub Pages.
