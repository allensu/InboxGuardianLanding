# 備援 Dockerfile - 如 Zeabur 靜態站點自動偵測失敗時使用
# 使用方式：在 Zeabur 專案設定中選擇 "Dockerfile" 而非自動偵測

FROM nginx:alpine

# 複製靜態檔案
COPY public /usr/share/nginx/html

# 複製 nginx 設定（若存在）
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Zeabur 會使用 $PORT 環境變數
ENV PORT=8080

# Listen on $PORT (Zeabur 的慣例)
CMD ["/bin/sh", "-c", "sed -i \"s/listen 8080/listen ${PORT:-8080}/g\" /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]

EXPOSE 8080
