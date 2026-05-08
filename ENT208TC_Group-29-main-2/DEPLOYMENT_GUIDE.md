# SuperTA 快速部署指南 (Quick Deployment Guide)

## ✅ 当前状态 (Current Status)
- ✅ 本地服务已在 **http://localhost:8000** 运行
- ✅ 局域网可访问：**http://10.13.66.89:8000**
- ✅ API key 已从环境变量读取（安全✓）
- ✅ 所有依赖已安装

---

## 🚀 快速启动方式 (Quick Start)

### 方式 1：使用启动脚本（推荐）
```bash
# 进入项目目录
cd /Users/mac/Desktop/SuperTA/ENT208TC_Group-29-main-2

# 运行启动脚本（一键启动）
./run.sh
```

### 方式 2：手动启动
```bash
# 激活虚拟环境
source .venv/bin/activate

# 导出 API key
export QWEN_API_KEY=sk-5478ef0c1b684875ad4c7979bd8f9d04

# 启动服务
uvicorn main:app --host 0.0.0.0 --port 8000
```

### 方式 3：后台启动
```bash
# 在项目目录运行
source .venv/bin/activate && export QWEN_API_KEY=sk-5478ef0c1b684875ad4c7979bd8f9d04 && nohup uvicorn main:app --host 0.0.0.0 --port 8000 > server.log 2>&1 &
```

---

## 🌐 访问方式 (Access Methods)

### 本地访问 (Local)
```
http://localhost:8000
```

### 同一 Wi‑Fi 网络访问 (Same LAN)
```
http://10.13.66.89:8000
```

### 从任何地方访问（公网）- 使用 ngrok
见下一节 👇

---

## 🔗 对外公开暴露（ngrok 方案）

### 第 1 步：安装 ngrok
在 macOS 上，使用 Homebrew：
```bash
brew install ngrok
```

或者从 https://ngrok.com/download 下载安装。

### 第 2 步：登录 ngrok 账户
1. 注册账户：https://ngrok.com
2. 获取 auth token（在 Dashboard 中显示）
3. 运行命令：
```bash
ngrok authtoken <你的_ngrok_token_here>
```

### 第 3 步：暴露本地服务
确保 FastAPI 服务已在运行（8000 端口），然后在 **新的终端** 中运行：

```bash
ngrok http 8000
```

### 第 4 步：获取公网链接
ngrok 会输出类似下面的内容：
```
ngrok                                       (Ctrl+C to quit)
                                                                
Session Status                online                            
Account                       <你的账户>
Version                        3.x.x                            
Region                         us (United States)              
Latency                        27ms                            
Web Interface                  http://127.0.0.1:4040           
Forwarding                     https://abcd-1234.ngrok.io -> http://localhost:8000
```

**关键信息：**
- 📍 **公网 URL**：https://abcd-1234.ngrok.io
- ✅ 自动启用 HTTPS（安全传输）
- ⏱️ 每次启动 ngrok 时 URL 会变化（除非购买固定域名）

### 第 5 步：分享链接
把 `https://abcd-1234.ngrok.io` 分享给任何人，他们即可访问你的服务！

---

## 🔒 安全注意事项 (Security Tips)

### ✅ 已做的安全措施：
1. **API key 已从环境变量读取** - 不再硬编码在代码中
2. **ngrok 自动启用 HTTPS** - 数据加密传输
3. **`.env` 文件已添加到项目**

### ⚠️ 生产环境建议：
1. **不要在公开环境中使用 `reload=True`**（会降低性能和安全性）
2. **设置 ngrok IP 白名单**（付费功能）或使用 HTTP basic auth
3. **定期更换 ngrok URL** 或购买固定域名
4. **不要把 `.env` 文件提交到 git**（已添加到 `.gitignore`，如果有的话）
5. **考虑添加速率限制** 防止 API 被滥用

---

## 📋 常见问题 (FAQ)

### Q: ngrok 链接过期了怎么办？
A: 每次关闭 ngrok 再启动时会产生新的 URL。你可以：
- 重新运行 `ngrok http 8000` 获取新 URL
- 购买 ngrok 的付费功能获得静态域名
- 使用完整域名自定义 ngrok URL

### Q: 如何停止服务？
A: 
- 如果是前台运行：按 `Ctrl+C`
- 如果是后台运行：
```bash
pkill -f "uvicorn main:app"
```

### Q: 本地服务不响应怎么办？
A:
```bash
# 1. 检查 8000 端口是否被占用
lsof -i :8000

# 2. 杀死占用的进程
lsof -i :8000 | grep LISTEN | awk '{print $2}' | xargs kill -9

# 3. 重新启动服务
```

### Q: 如何在生产环境部署？
A: 见本指南底部的"生产环境部署"部分。

---

## 🎯 生产环境部署选项 (Production Deployment)

### 选项 1：VPS 部署（最推荐）
适合需要长期、稳定、自定义域名的场景。

**关键步骤：**
1. 购买 VPS（如 DigitalOcean、Linode、AWS EC2）
2. 部署代码、启动 Uvicorn
3. 配置 Nginx 反向代理
4. 使用 Certbot 申请 HTTPS 证书

**成本**：$3-10/月

### 选项 2：容器化部署（Docker）
适合需要快速扩展、多环境部署的场景。

```bash
# 创建 Dockerfile
# 构建镜像
# 推送到 Docker Hub 或私有仓库
# 在云主机或 Kubernetes 上运行
```

### 选项 3：PaaS 平台（如 Railway、Render、Heroku）
适合快速上线、不想维护基础设施的场景。

**优点**：
- 自动扩展、负载均衡
- 免费 HTTPS
- 自动重启

**缺点**：
- 成本随流量增加
- 有时性能限制

---

## 📞 需要帮助？

如果遇到问题，请检查：
1. ✅ `.env` 文件中是否正确设置了 `QWEN_API_KEY`
2. ✅ 虚拟环境是否已激活
3. ✅ 所有依赖是否已安装（`pip list`）
4. ✅ 8000 端口是否被占用

---

**祝你部署顺利！🎉**
