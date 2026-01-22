# Use the requested Scipy Notebook base
FROM quay.io/jupyter/scipy-notebook:python-3.13

# Install the Kernel Gateway
RUN pip install --no-cache-dir jupyter-kernel-gateway

# Expose the custom port
EXPOSE 9999

# Configure the Kernel Gateway to run on startup
# We use the flags to ensure WebSockets are enabled and auth is disabled
CMD ["jupyter", "kernelgateway", \
     "--KernelGatewayApp.ip=0.0.0.0", \
     "--KernelGatewayApp.port=9999", \
     "--KernelGatewayApp.auth_token=''", \
     "--JupyterWebsocketPersonality.list_kernels=True"]
