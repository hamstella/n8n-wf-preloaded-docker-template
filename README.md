# n8n-wf-preloaded-docker-template

作成済みのn8nワークフローをインポートしたDockerイメージを作成するためのテンプレートプロジェクトです。

## 🚀 クイックスタート

```bash
# 1. リポジトリをクローン
git clone https://github.com/your-org/llm-workflow-n8n.git
cd llm-workflow-n8n

# 2. 環境設定ファイルを作成
cp .env.example .env

# 3. .envファイルを編集（必須項目を設定）
# - 必要に応じて環境変数を設定

# 4. n8nを起動
docker compose up -d

# 5. ブラウザでアクセス
# http://localhost:5678
```

## 📋 前提条件

- Docker と Docker Compose がインストールされていること
- n8nで作成済みのワークフローファイル（JSON形式）

## 🎯 プロジェクトの特徴

- **ワークフロー組み込み**: 作成済みのn8nワークフローを事前にインポート
- **即座に利用可能**: コンテナ起動時に自動的にワークフローが有効化
- **カスタムイメージ**: 外部ボリューム不要の自己完結型Dockerイメージ
- **簡単なデプロイ**: ワークフローを含んだ状態でコンテナを配布可能

## 😇 課題

- 起動後の初回アクセスで管理アカウント作成画面が表示されてしまう
- ログの管理（実行ログ、n8nのログ）

## 📁 プロジェクト構成

```
.
├── docker-compose.yml    # Docker Compose設定
├── Dockerfile           # カスタムn8nイメージ定義
├── entrypoint.sh        # カスタムエントリーポイント
├── .env.example         # 環境変数テンプレート
├── .env                 # 環境変数設定（Gitで管理されない）
├── .gitignore          # Git除外設定
├── .dockerignore       # Dockerビルド除外設定
├── workflows/          # n8nワークフローファイル
│   └── DomainSearch.json  # サンプルワークフロー（任意のワークフローを配置）
├── test.sh             # ワークフローテスト用スクリプト
└── test-payload.json   # テスト用ペイロードデータ
```

## 🔧 設定

### 環境変数

`.env.example`をコピーして`.env`を作成してください：
- その他、ワークフローで使用する環境変数を適宜追加

### ワークフローファイルの配置

- `workflows/`: エクスポートしたワークフローファイルを配置します

#### カスタムイメージの特徴

- **ワークフロー事前インストール**: `workflows/`ディレクトリ内のすべての`.json`ファイルが自動的にインポートされます
- **自動インポート**: コンテナ起動時に自動的にワークフローがn8nに登録されます

## 🔒 セキュリティ

- 機密情報は環境変数で管理（.envファイルはGitに含めない）

## 📚 参考リンク

- [n8n公式ドキュメント](https://docs.n8n.io/)
- [n8n Workflow Examples](https://n8n.io/workflows/)
