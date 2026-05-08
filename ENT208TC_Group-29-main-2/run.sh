#!/bin/bash

# SuperTA 快速启动脚本（macOS / Linux）
# Quick startup script for SuperTA

set -e  # 任何错误时停止脚本 / Exit on any error

echo "🚀 SuperTA 启动中 (Starting SuperTA)..."

# 1. 检查虚拟环境
if [ ! -d ".venv" ]; then
    echo "📦 创建虚拟环境 (Creating virtual environment)..."
    python3 -m venv .venv
fi

# 2. 激活虚拟环境
source .venv/bin/activate
echo "✅ 虚拟环境已激活 (Virtual environment activated)"

# 3. 安装依赖
echo "📚 安装依赖 (Installing dependencies)..."
pip install -r requirements.txt

# 4. 加载 .env 文件中的环境变量
if [ -f ".env" ]; then
    echo "🔑 加载 .env 文件 (Loading .env file)..."
    export $(cat .env | grep -v '#' | xargs)
else
    echo "⚠️  警告: 未找到 .env 文件 (Warning: .env file not found)"
    echo "📝 请复制 .env.example 并填入你的 QWEN_API_KEY"
    echo "   Please copy .env.example and fill in your QWEN_API_KEY"
    exit 1
fi

# 5. 检查 API key
if [ -z "$QWEN_API_KEY" ]; then
    echo "❌ 错误: QWEN_API_KEY 未设置 (ERROR: QWEN_API_KEY not set)"
    exit 1
fi

echo "✅ 所有检查通过 (All checks passed)"
echo ""
echo "🌐 启动 FastAPI 服务 (Starting FastAPI server)..."
echo "   本地访问 (Local access): http://localhost:8000"
echo "   局域网访问 (LAN access):  http://<你的IP>:8000"
echo ""
echo "📢 启用 ngrok 暴露到公网 (To expose to public internet):"
echo "   在另一个终端运行 (Run in another terminal):"
echo "   ngrok http 8000"
echo ""

# 6. 启动服务（带自动重载）
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
