# LLM-WORKFLOW-N8N

n8nで複数のLLMを連携させたワークフローをAPI化し、Kubernetes上で運用するためのプロジェクトです。

## 🚀 クイックスタート

```bash
# 1. リポジトリをクローン
git clone https://github.com/your-org/llm-workflow-n8n.git
cd llm-workflow-n8n

# 2. 環境設定ファイルを作成
cp .env.example .env

# 3. .envファイルを編集（必須項目を設定）
# - N8N_BASIC_AUTH_PASSWORD を安全なパスワードに変更
# - OPENAI_API_KEY を設定（OpenAIを使用する場合）
# - ANTHROPIC_API_KEY を設定（Claudeを使用する場合）

# 4. n8nを起動
docker compose up -d

# 5. ブラウザでアクセス
# http://localhost:5678
# Basic認証: admin / (設定したパスワード)
```

## 📋 前提条件

- Docker と Docker Compose がインストールされていること
- OpenAI API Key または Anthropic API Key（LLMワークフロー用）

## 🎯 プロジェクトの目標

- **APIエンドポイント化**: n8nで作成したワークフローをREST APIとして提供
- **複数LLM連携**: OpenAI、Anthropicなど複数のLLMを組み合わせた高度な処理
- **Kubernetes対応**: 本番環境でのスケーラブルな運用
- **コンテナ化**: ワークフロー組み込み済みのDockerイメージ

## 📁 プロジェクト構成

```
.
├── docker-compose.yml    # Docker Compose設定
├── .env.example         # 環境変数テンプレート
├── .gitignore          # Git除外設定
├── .dockerignore       # Dockerビルド除外設定
├── workflows/          # n8nワークフローファイル
│   └── DomainSearch.json  # ドメインモデリング用ワークフロー
├── docker/             # Dockerビルド用ファイル
│   ├── Dockerfile      # カスタムn8nイメージ定義
│   ├── entrypoint.sh   # カスタムエントリーポイント
│   └── import-workflows.js  # ワークフローインポートスクリプト
├── k8s/                # Kubernetesマニフェスト
└── docs/               # ドキュメント
```

## 🔧 設定

### 環境変数

`.env.example`をコピーして`.env`を作成し、以下の必須項目を設定してください：

- `N8N_BASIC_AUTH_PASSWORD`: n8nへのアクセスパスワード（必須）
- `OPENAI_API_KEY`: OpenAI APIキー（OpenAIを使用する場合）
- `ANTHROPIC_API_KEY`: Anthropic APIキー（Claudeを使用する場合）

### データの永続化

- `n8n_data/`: n8nの設定、アカウント情報、実行履歴などが保存されます
- `workflows/`: エクスポートしたワークフローファイルを配置します

## 🛠️ 開発手順

### 1. ワークフローの作成

1. n8nにアクセス（http://localhost:5678）
2. 新しいワークフローを作成
3. 必要なノードを配置（Webhook、OpenAI、Code等）
4. ワークフローを保存してテスト

### 2. ワークフローのエクスポート

1. 作成したワークフローを選択
2. メニューから「Download」を選択
3. JSONファイルを`workflows/`ディレクトリに保存

### 3. APIエンドポイントとしてテスト

```bash
# Webhookエンドポイントにリクエスト送信
curl -X POST http://localhost:5678/webhook/your-webhook-path \
  -H "Content-Type: application/json" \
  -d '{"prompt": "テストメッセージ"}'
```

## 📦 本番環境へのデプロイ

### Dockerイメージのビルド

```bash
# ワークフロー組み込み済みイメージのビルド（方法1: 直接ビルド）
docker build -t your-registry/n8n-llm-workflow:latest -f docker/Dockerfile .

# ワークフロー組み込み済みイメージのビルド（方法2: Docker Compose使用）
docker compose build

# イメージのテスト起動
docker compose up -d

# ログの確認（ワークフローインポート状況を確認）
docker compose logs n8n
```

#### カスタムイメージの特徴

- **ワークフロー事前インストール**: `workflows/`ディレクトリ内のすべての`.json`ファイルが自動的にインポートされ、有効化されます
- **自動インポート**: コンテナ起動時に自動的にワークフローがn8nに登録されます
- **本番環境対応**: 外部ボリュームマウント不要で、完全に自己完結したイメージです

### Kubernetesへのデプロイ

```bash
# イメージをレジストリにプッシュ
docker tag llm-workflow-n8n:latest your-registry/n8n-llm-workflow:latest
docker push your-registry/n8n-llm-workflow:latest

# マニフェストの適用
kubectl apply -f k8s/
```

## ⚙️ ワークフロー管理

### 新しいワークフローの追加

1. n8nでワークフローを作成・テスト
2. ワークフローをエクスポート（JSON形式）
3. `workflows/`ディレクトリに保存
4. Dockerイメージを再ビルド

```bash
# 新しいワークフローでイメージを更新
docker compose build --no-cache
docker compose up -d
```

### ワークフローの確認

```bash
# コンテナ内のワークフローファイル確認
docker compose exec n8n ls -la /data/workflows/

# インポートログの確認
docker compose logs n8n | grep -i "workflow"
```

## 🔒 セキュリティ

- Basic認証でn8nへのアクセスを保護
- APIキーは環境変数で管理（.envファイルはGitに含めない）
- 本番環境では適切なシークレット管理を使用

## 🐛 トラブルシューティング

### n8nが起動しない場合

```bash
# ログを確認
docker compose logs n8n

# コンテナを再起動
docker compose restart
```

### データをリセットしたい場合

```bash
# 警告: すべてのデータが削除されます
docker compose down
rm -rf n8n_data/*
docker compose up -d
```

## 📚 参考リンク

- [n8n公式ドキュメント](https://docs.n8n.io/)
- [n8n Workflow Examples](https://n8n.io/workflows/)
- [詳細な実装手順](./step-by-step.md)
