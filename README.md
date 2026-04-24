# 🛡️ 護信者 InboxGuardian - Landing Page

Chrome Extension 的官方 Landing Page。純靜態 HTML + Tailwind CDN，透過 **GitHub Pages** 自動部署。

## 🌐 正式網址

https://allensu.github.io/InboxGuardianLanding

## 📁 專案結構

```
InboxGuardianLanding/
├── index.html                 ← 主頁
├── assets/                    ← 圖片與 icon
│   ├── screenshot-*.png
│   ├── og-image.png
│   └── favicon-*.png
├── .github/workflows/
│   └── deploy-pages.yml       ← 自動部署到 GitHub Pages
├── package.json
└── 備援部署方案（可忽略）：
    ├── zbpack.json            ← Zeabur 設定
    ├── Dockerfile             ← Docker 部署
    ├── nginx.conf             ← Nginx 設定
    └── DEPLOYMENT.md          ← Zeabur 部署指引
```

## 🚀 本地預覽

```bash
# 用 npm
npm run dev

# 或直接用 Python
python3 -m http.server 3000

# 訪問 http://localhost:3000
```

## 🔄 部署流程

### 自動部署（預設）

只要 `git push` 到 `main` 分支：

```
你 push 程式碼
    ↓
GitHub Actions 自動觸發
    ├── 驗證 HTML 與資源
    ├── 打包 Pages artifact
    └── 部署到 GitHub Pages
    ↓
1-2 分鐘後更新上線
```

### 首次啟用 GitHub Pages

1. 推送程式碼到 `main` 分支
2. 到 GitHub repo 的 **Settings → Pages**
3. **Source**: 選擇 `GitHub Actions`（不是 deploy from branch）
4. 儲存後即可自動使用 workflow 部署
5. 首次部署完成後，網址會顯示在 Settings → Pages

## 🎨 更新內容

### 更新截圖

```bash
cp new-screenshot.png assets/screenshot-1-overview.png
git add assets/
git commit -m "chore: update screenshot"
git push
```

### 更新文案

直接編輯 `index.html`，commit 後自動部署。

### 更新版本號

修改 `index.html` 中的 `v1.1.0` 字串即可。

## 🔗 與 Extension Repo 的關聯

Landing page 指向的連結：
- 下載按鈕 → https://github.com/allensu/InboxGuardianExtension/releases/latest
- 原始碼 → https://github.com/allensu/InboxGuardianExtension
- 隱私政策 → https://github.com/allensu/InboxGuardianExtension/blob/main/PRIVACY-POLICY.md

## 🎨 設計系統

- **主色**: Brand Green `#059669` → `#10b981`
- **字型**: system font stack (`-apple-system`, PingFang TC, Microsoft JhengHei)
- **響應式**: Tailwind 預設（sm: 640px, md: 768px, lg: 1024px）

## 💡 為什麼用 GitHub Pages？

- ✅ **完全免費**
- ✅ **零設定**：push 就自動部署
- ✅ **全球 CDN**：速度快
- ✅ **自動 HTTPS**：SSL 憑證 GitHub 自動處理
- ✅ **不需要第三方服務**

缺點：
- 不支援 SSR / API routes（本專案不需要，純靜態）
- 自訂網域需要 DNS 設定（也很簡單）

## 📄 License

MIT
