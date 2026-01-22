# Jupyter Kernel Gateway - Scipy Notebook

A headless Jupyter Kernel Gateway container based on the official Jupyter Scipy Notebook, providing kernel execution capabilities via REST API and WebSocket connections.

## Features

- **Base Image**: `quay.io/jupyter/scipy-notebook:python-3.13`
- **Pre-installed Libraries**: NumPy, SciPy, Pandas, Matplotlib, and other scientific Python packages
- **Headless Service**: Jupyter Kernel Gateway (no UI)
- **API Port**: 9999
- **WebSocket Support**: Enabled for kernel communication
- **Authentication**: Disabled (intended for development/private network use)

## Quick Start

### Option 1: Use Pre-built Image from GitHub Container Registry

```bash
docker pull ghcr.io/OWNER/REPO:latest
docker run -p 9999:9999 ghcr.io/OWNER/REPO:latest
```

> **Note**: Replace `OWNER/REPO` with your GitHub username and repository name (e.g., `username/jupter-gateway-image`)

### Option 2: Build Locally

```bash
docker build -t scipy-kernel-gateway .
docker run -p 9999:9999 scipy-kernel-gateway
```

The gateway will be accessible at `http://localhost:9999`

## Usage Examples

### List Available Kernels

```bash
curl http://localhost:9999/api/kernels
```

### Start a New Kernel

```bash
curl -X POST http://localhost:9999/api/kernels
```

### Connect via WebSocket

Once you have a kernel ID, you can connect to it via WebSocket at:
```
ws://localhost:9999/api/kernels/<kernel-id>/channels
```

## Advanced Configuration

### Run with Volume Mounting

To persist notebooks or access local files:

```bash
docker run -p 9999:9999 -v $(pwd)/notebooks:/home/jovyan/work scipy-kernel-gateway
```

### Run in Detached Mode

```bash
docker run -d -p 9999:9999 --name jupyter-gateway scipy-kernel-gateway
```

### Custom Environment Variables

```bash
docker run -p 9999:9999 -e MY_VAR=value scipy-kernel-gateway
```

## Security Considerations

⚠️ **Warning**: This container is configured with **disabled authentication** for development purposes.

For production use, consider:
- Enabling token authentication
- Running behind a reverse proxy with proper authentication
- Using HTTPS/WSS for encrypted connections
- Restricting network access

## Technical Details

### CI/CD - Automated Builds

This repository includes a GitHub Actions workflow that automatically:
- Builds the Docker image on every push to `main`/`master`
- Publishes multi-platform images (amd64, arm64) to GitHub Container Registry
- Tags images based on:
  - Branch name for branch pushes
  - Semantic version for tagged releases (e.g., `v1.0.0` → tags `1.0.0`, `1.0`, `1`, `latest`)
  - Git SHA for traceability

**Available Image Tags:**
- `latest` - Latest build from the default branch
- `v1.2.3` - Specific semantic version
- `main` - Latest build from main branch
- `main-<sha>` - Specific commit from main branch

### Exposed Ports
- `9999`: Jupyter Kernel Gateway API and WebSocket

### Container Configuration
- IP Binding: `0.0.0.0` (all interfaces)
- Authentication Token: Disabled
- WebSocket Personality: List kernels enabled

## Troubleshooting

### Check Container Logs

```bash
docker logs <container-id>
```

### Verify Gateway is Running

```bash
curl http://localhost:9999/api
```

Expected response should include API version information.

## License

See [LICENSE](LICENSE) file for details.
