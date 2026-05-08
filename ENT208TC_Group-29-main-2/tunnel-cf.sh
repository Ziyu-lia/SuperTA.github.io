#!/bin/bash
# 启动 Cloudflare Tunnel 以暴露本地服务到公网
# Start Cloudflare Tunnel to expose local service to internet

echo "🚀 启动 Cloudflare Tunnel..."
echo "Starting Cloudflare Tunnel..."
echo ""

# 启动 cloudflared
/usr/local/bin/cloudflared tunnel --url http://localhost:8000

