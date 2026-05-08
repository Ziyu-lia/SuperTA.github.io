#!/bin/bash
# SuperTA 快速启动参考卡 (Quick Reference Card)

cat << 'EOF'
╔════════════════════════════════════════════════════════════════════════════╗
║                  🎉 SuperTA 部署完成！快速启动指南 🎉                      ║
╚════════════════════════════════════════════════════════════════════════════╝

📍 当前状态：
   ✅ 服务运行中 (PID: 772)
   📍 本地访问: http://localhost:8000
   📍 局域网访问: http://10.13.66.89:8000
   🔐 API Key: 已从环境变量读取（安全）

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 对外公开方案（3 步）：

  1️⃣  启动本地服务（项目目录）
      ./run.sh
      
      或手动：
      source .venv/bin/activate
      export QWEN_API_KEY=sk-5478ef0c1b684875ad4c7979bd8f9d04
      uvicorn main:app --host 0.0.0.0 --port 8000

  2️⃣  安装 ngrok（第一次）
      brew install ngrok
      ngrok authtoken <你的_token>

  3️⃣  暴露到公网（在新终端）
      ngrok http 8000
      
      复制输出中的 URL：https://xxxxxxxx.ngrok.io
      分享给任何人！👥

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 已准备好的文件：

   • main.py             - 已修改（API Key 环境变量化）
   • run.sh              - 一键启动脚本 ✨
   • .env                - 环境变量配置
   • .env.example        - 配置模板
   • Dockerfile          - Docker 容器配置
   • DEPLOYMENT_GUIDE.md - 完整部署指南（包含生产环境选项）
   • DEPLOYMENT_COMPLETE.md - 此部署摘要

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 快速命令：

   启动服务（后台）：
   nohup uvicorn main:app --host 0.0.0.0 --port 8000 > server.log 2>&1 &

   查看日志：
   tail -f server.log

   停止服务：
   pkill -f "uvicorn main:app"

   检查端口状态：
   lsof -i :8000

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔒 安全提醒：

   ⚠️  不要提交 .env 到 git（添加到 .gitignore）
   ⚠️  ngrok URL 每次启动会变化（升级 Pro 获得静态域名）
   ⚠️  生产环境删除 --reload（影响性能）
   ✅  HTTPS 自动启用（ngrok 处理）

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📚 更多帮助：

   完整部署指南  →  DEPLOYMENT_GUIDE.md
   故障排查    →  DEPLOYMENT_GUIDE.md (FAQ 部分)
   生产环境    →  DEPLOYMENT_GUIDE.md (生产环境部署)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 你已准备好将 SuperTA 分享给全世界！🌍

现在就运行：ngrok http 8000 并分享链接吧！🚀

EOF
