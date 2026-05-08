# 🌍 你的 SuperTA 网站 - 全球访问指南

## ✅ 当前状态
- ✅ 服务运行中：`http://localhost:8000`
- ✅ 局域网访问：`http://10.13.66.89:8000`
- ✅ Cloudflare Tunnel 已安装：`/usr/local/bin/cloudflared`

---

## 🚀 方案 2：Cloudflare Tunnel（无需认证，完全免费）

### 步骤 1：打开新的终端窗口
按 `⌘ + T` 或在 VS Code 中打开新终端

### 步骤 2：在新终端中运行以下命令
```bash
cd /Users/mac/Desktop/SuperTA/ENT208TC_Group-29-main-2
/usr/local/bin/cloudflared tunnel --url http://localhost:8000
```

### 步骤 3：等待 5-10 秒后，你会看到类似这样的输出

```
2026-05-07T11:25:00Z INF Requesting new quick Tunnel on trycloudflare.com...
2026-05-07T11:25:05Z INF +----------------------------+
2026-05-07T11:25:05Z INF |  https://abc123def456.trycloudflare.com  |  ← 这就是你的链接！
2026-05-07T11:25:05Z INF +----------------------------+
2026-05-07T11:25:05Z INF listening on unix socket /tmp/cloudflared.sock
```

### 步骤 4：复制 HTTPS 链接并分享！

例如：`https://abc123def456.trycloudflare.com`

**任何人都可以打开这个链接访问你的网站！** 🎉

---

## 💡 三种访问方式对比

| 方式 | URL | 适用场景 | 稳定性 | 步骤 |
|------|-----|--------|-------|-----|
| **本机** | http://localhost:8000 | 仅自己 | 100% | 0 步 |
| **局域网** | http://10.13.66.89:8000 | 同 Wi-Fi | 100% | 0 步 |
| **全球（Cloudflare Tunnel）** | https://xxx.trycloudflare.com | 全球任何人 | 95% | 1 条命令 |

---

## ⚠️ 注意事项

1. **链接会变化**：每次重启 cloudflared 时，URL 会变化（这是免费版的特性）
2. **保持运行**：cloudflared 必须一直运行，否则链接失效
3. **HTTPS 自动启用**：所有数据加密传输（安全✓）
4. **无流量限制**：完全免费，不限流量

---

## 🎯 快速启动命令

```bash
# 打开新终端，运行这一行：
/usr/local/bin/cloudflared tunnel --url http://localhost:8000
```

完全就这么简单！ ✨

---

## 📍 已有的文件

- `run.sh` - 启动本地服务
- `tunnel-cf.sh` - 启动 Cloudflare Tunnel
- `.env` - 环境变量配置
- `DEPLOYMENT_GUIDE.md` - 完整部署文档

---

## 🔗 你的网站现在可以分享了！

**选择你要分享的链接：**

- 📱 **仅团队**：http://10.13.66.89:8000
- 🌍 **全球**：https://xxx.trycloudflare.com （运行上面的命令后获得）

**立即开始**：在新终端运行 `/usr/local/bin/cloudflared tunnel --url http://localhost:8000`

---

祝你分享顺利！🚀
