#!/bin/sh

# n8nを起動
n8n start &
N8N_PID=$!

# n8nが完全に起動するまで待機
echo "Waiting for n8n to start..."
sleep 10

# ワークフローをインポート
echo "Importing workflows..."
n8n import:workflow --separate --input=/workflows

# n8nプロセスをフォアグラウンドに移動
echo "n8n is ready!"
wait $N8N_PID