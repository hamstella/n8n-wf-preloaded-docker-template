FROM n8nio/n8n:latest

# ワークフローディレクトリをコンテナにコピー
COPY workflows /workflows

# entrypointスクリプトをコピー
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# n8nのデフォルトの作業ディレクトリ
WORKDIR /home/node/.n8n

# カスタムentrypointを設定
ENTRYPOINT ["/entrypoint.sh"]