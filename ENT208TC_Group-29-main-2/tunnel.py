#!/usr/bin/env python3
"""
简单的本地隧道 - 将本地 8000 端口暴露到公网
Simple local tunnel - Expose local port 8000 to public internet
"""

import subprocess
import sys
import time
import json

def check_ngrok_auth():
    """检查 ngrok 是否已认证"""
    result = subprocess.run(['/usr/local/bin/ngrok', 'config', 'check'], 
                          capture_output=True, text=True)
    return result.returncode == 0

def get_ngrok_url():
    """从 ngrok API 获取公网 URL"""
    try:
        result = subprocess.run(['curl', '-s', 'http://localhost:4040/api/tunnels'],
                              capture_output=True, text=True, timeout=5)
        if result.returncode == 0:
            data = json.loads(result.stdout)
            for tunnel in data.get('tunnels', []):
                if 'https://' in tunnel.get('public_url', ''):
                    return tunnel['public_url']
    except Exception as e:
        print(f"Error getting ngrok URL: {e}", file=sys.stderr)
    return None

def start_tunnel():
    """启动 ngrok 隧道"""
    print("🚀 正在启动公网隧道 (Starting public tunnel)...", file=sys.stderr)
    print("", file=sys.stderr)
    
    # 启动 ngrok
    try:
        proc = subprocess.Popen(['/usr/local/bin/ngrok', 'http', '8000', '--log=stdout'],
                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                               text=True, bufsize=1)
        
        # 等待隧道启动并读取 URL
        url = None
        start_time = time.time()
        timeout = 10
        
        for line in proc.stdout:
            print(line.rstrip(), file=sys.stderr)
            if 'https://' in line and 'Forwarding' in line:
                # 从行中提取 URL
                parts = line.split()
                for part in parts:
                    if part.startswith('https://'):
                        url = part
                        break
            if url and time.time() - start_time > 2:
                break
            if time.time() - start_time > timeout:
                break
        
        if url:
            print("", file=sys.stderr)
            print("=" * 80, file=sys.stderr)
            print("✅ 隧道已建立！(Tunnel established!)", file=sys.stderr)
            print("", file=sys.stderr)
            print(f"🌍 公网链接 (Public URL): {url}", file=sys.stderr)
            print("", file=sys.stderr)
            print("📢 分享这个链接给任何人 (Share this link with anyone):", file=sys.stderr)
            print(f"   {url}", file=sys.stderr)
            print("", file=sys.stderr)
            print("=" * 80, file=sys.stderr)
            print("", file=sys.stderr)
            print("💡 按 Ctrl+C 停止隧道", file=sys.stderr)
            print("", file=sys.stderr)
        
        # 保持进程运行
        proc.wait()
        
    except KeyboardInterrupt:
        print("\n🛑 隧道已停止 (Tunnel stopped)", file=sys.stderr)
        sys.exit(0)
    except FileNotFoundError:
        print("❌ ngrok 未找到！请先安装 ngrok", file=sys.stderr)
        print("Download ngrok: https://ngrok.com/download", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"❌ 错误: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == '__main__':
    start_tunnel()
