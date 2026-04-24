# 🚀 完整部署手冊：從 GitHub 到 Zeabur

本手冊帶你一步步把 Landing Page 上線。預計耗時 **15 分鐘**。

## 📋 前置需求

- [x] GitHub 帳號
- [x] Zeabur 帳號（可用 GitHub 登入，免費方案夠用）
- [x] 本機安裝 Git

---

## Step 1: 建立 GitHub Repo

### 1.1 前往 GitHub 建立新 repo

1. 登入 [github.com](https://github.com)
2. 右上角「+」→「**New repository**」
3. 填寫：
   - **Repository name**: `InboxGuardianLanding`
   - **Description**: `Landing page for InboxGuardian Chrome Extension`
   - **Visibility**: `Public`（如果想公開）或 `Private`（朋友用）
   - ❌ **不要** 勾選任何初始化選項（README / .gitignore / license）
4. 點擊「**Create repository**」

### 1.2 本機推送程式碼

在本專案資料夾（`inboxguardian-landing/`）執行：

```bash
git init
git add .
git commit -m "feat: initial landing page"
git branch -M main
git remote add origin https://github.com/allensu/InboxGuardianLanding.git
git push -u origin main
```

> ⚠️ 你的 GitHub 帳號已設為 `allensu`，若不同請自行替換

### 1.3 驗證推送成功

瀏覽器打開 `https://github.com/allensu/InboxGuardianLanding`，應該能看到所有檔案。

---

## Step 2: 連接 Zeabur

### 2.1 登入 Zeabur

1. 前往 [dash.zeabur.com](https://dash.zeabur.com)
2. 點擊「**用 GitHub 登入**」
3. 授權 Zeabur 存取你的 GitHub（首次會跳出）

### 2.2 建立專案並部署

1. 進入 Zeabur Dashboard
2. 點擊「**建立專案 / Create Project**」
3. 選擇一個 Region（建議選 **Hong Kong** 或 **Singapore**，台灣使用者延遲低）
4. 點擊「**部署新服務 / Deploy New Service**」
5. 選擇「**從 GitHub 部署 / Deploy from GitHub**」
6. 如果是第一次使用，會要求你授權 Zeabur 存取特定 repo：
   - 選「**Only select repositories**」
   - 選 `InboxGuardianLanding`
   - 點擊「**Install & Authorize**」
7. 回到 Zeabur，選擇剛授權的 `InboxGuardianLanding` repo
8. Zeabur 會自動偵測到 `zbpack.json`，開始建置

### 2.3 等待部署完成

- 建置時間約 **1-2 分鐘**
- 可在 Zeabur 的 Logs 頁面即時查看建置進度
- 完成後會顯示：**Deployment successful**

### 2.4 取得你的網址

1. 在 Zeabur 專案中點擊服務卡片
2. 找到「**Domain / 網域**」頁籤
3. 點擊「**Generate Domain**」自動產生一個 `.zeabur.app` 網址
   - 例如：`InboxGuardianLanding.zeabur.app`
4. 點擊網址測試是否能正常打開

---

## Step 3: 綁定自訂網域（選用）

如果你有自己的網域（例如 `example.com`），想用 `inboxguardian.example.com`：

### 3.1 在 Zeabur 新增自訂網域

1. 在服務的「**Domain**」頁籤點擊「**Add Domain**」
2. 輸入你想用的子網域，例如 `inboxguardian.example.com`
3. Zeabur 會給你一串 CNAME 值（例如 `xxx.zeabur.app`）

### 3.2 設定 DNS

前往你的網域管理介面（Cloudflare / GoDaddy / Gandi 等）：

1. 新增一筆 **CNAME 記錄**：
   - **Name/Host**: `inboxguardian`（對應你要的子網域前綴）
   - **Target/Value**: Zeabur 提供的 `xxx.zeabur.app`
   - **TTL**: Auto 或 3600
2. 儲存

### 3.3 等待 DNS 生效

- 通常 **5-30 分鐘** 生效
- Zeabur 會自動申請 SSL 憑證（Let's Encrypt）

---

## Step 4: 驗證 CI/CD

### 4.1 做個小修改測試自動部署

```bash
# 在 public/index.html 隨便改個文字
# 例如把版本號從 v1.0.0 改成 v1.0.1

git add .
git commit -m "test: verify auto deploy"
git push
```

### 4.2 觀察自動部署流程

1. **GitHub Actions**：前往 `https://github.com/allensu/InboxGuardianLanding/actions` 應該能看到新的 workflow run
2. **Zeabur**：在 Zeabur Dashboard 的 Deployments 頁籤會看到新的部署正在進行
3. **等 1-2 分鐘**，重新整理你的網址應該會看到改動

---

## 🎯 常見問題排查

### ❓ Zeabur 顯示 "No index.html found"

**原因**: Zeabur 沒有正確識別 `public/` 為靜態根目錄。

**解決**:
1. 確認 `zbpack.json` 內容為：
   ```json
   {
     "output_dir": "public"
   }
   ```
2. 在 Zeabur 專案設定中，將 Builder 改為「**Static**」，並手動設定 Output Directory 為 `public`

### ❓ 部署成功但網頁是 404

**原因**: nginx 或靜態服務器沒找到 index.html

**解決**: 改用 Dockerfile 部署
1. 在 Zeabur 專案設定 → Builder → 改為「**Dockerfile**」
2. 專案中已有 `Dockerfile`，會自動使用

### ❓ CSS 樣式跑掉（因為 Tailwind CDN 載不到）

**原因**: 首次載入較慢，或網路環境無法連 cdn.tailwindcss.com

**解決**: 這是 CDN 本身的問題。如需完全離線運作，可改用 Tailwind CLI build 完整版：
```bash
npx tailwindcss -i input.css -o public/tailwind.css --minify
```
然後把 `<script src="https://cdn.tailwindcss.com"></script>` 換成 `<link rel="stylesheet" href="/tailwind.css">`

### ❓ GitHub Actions workflow 一直失敗

**原因**: HTML 驗證警告或檔案缺失

**解決**:
1. 點進失敗的 workflow 看詳細 log
2. 通常是圖片檔名不對或 placeholder 沒換掉
3. 修正後再 push

### ❓ 想在本機預覽再 push

```bash
cd public
python3 -m http.server 3000
# 開啟 http://localhost:3000
```

---

## 💰 Zeabur 費用說明

- **免費方案（Free）**: 每月 $5 美金的 credits
- **本 Landing Page 預估用量**: 靜態站點非常省資源，每月約消耗 $0.3-1 美金
- **結論**: 免費方案完全夠用，不會扣到信用卡

如果之後流量爆增（例如被熱門社群轉發），Zeabur 會自動告警，你再決定要不要升級。

---

## 🎁 Bonus: 進階優化

### 壓縮圖片

```bash
# 用 pngquant 壓縮 PNG（減少 50-70% 檔案大小）
brew install pngquant  # macOS
# 或 apt install pngquant  # Linux

cd public/assets
pngquant --quality=65-85 --ext=.png --force *.png
```

### 加入 Google Analytics

在 `index.html` 的 `</head>` 前加上：

```html
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXX');
</script>
```

### 加入 OG Image 預覽

分享到 Facebook / LINE / Twitter 時會自動顯示 `og-image.png`（已設定好）。

---

## 📞 需要幫助？

- Zeabur 官方文件：https://zeabur.com/docs
- Zeabur Discord：https://discord.gg/zeabur
- GitHub Issues：回到本專案提 issue
