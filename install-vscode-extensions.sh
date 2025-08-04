#!/bin/bash

# VS Code拡張機能インストールスクリプト

echo "VS Code拡張機能をインストール中..."

# インストール済み拡張機能一覧
extensions=(
    # AI支援・コード生成
    "anthropic.claude-code"                     # Claude Code
    "github.copilot"                            # GitHub Copilot - AI コード補完
    "github.copilot-chat"                       # GitHub Copilot Chat - AI チャット

    # Git・バージョン管理
    "github.vscode-pull-request-github"         # GitHub PR・Issue管理
    "mhutchie.git-graph"                        # Git履歴グラフ表示
    "github.vscode-github-actions"              # GitHub Actions - CI/CD 管理

    # Markdown・ドキュメント
    "bierner.markdown-mermaid"                  # Mermaid図表をMarkdownで表示
    "marp-team.marp-vscode"                     # Marp - Markdownプレゼンテーション
    "hediet.vscode-drawio"                      # Draw.io 図表作成
    "romanpeshkov.vscode-text-tables"           # テキストテーブル編集支援
    "takumii.markdowntable"                     # Markdownテーブル編集

    # コード品質・フォーマット
    "esbenp.prettier-vscode"                    # Prettier - コードフォーマッター

    # 開発・デバッグ・テスト
    "humao.rest-client"                         # REST Client - HTTP リクエスト送信

    # Diff
    "moshfeu.compare-folders"                   # フォルダ比較ツール

    # 設定・構成ファイル
    "redhat.vscode-xml"                         # XML 言語サポート
    "redhat.vscode-yaml"                        # YAML 言語サポート
    "mechatroner.rainbow-csv"                   # CSV ファイルの色分け表示

    # データベース・SQL
    "ms-mssql.data-workspace-vscode"            # データワークスペース
    "ms-mssql.mssql"                            # SQL Server拡張機能
    "ms-mssql.sql-bindings-vscode"              # SQL バインディング
    "ms-mssql.sql-database-projects-vscode"     # SQL データベースプロジェクト

    # インフラ・クラウド
    "hashicorp.terraform"                       # Terraform構文サポート
    "ms-azuretools.vscode-azureterraform"       # Azure Terraform
    "ms-azuretools.vscode-azure-mcp-server"     # Azure MCP Server
    "ms-azuretools.vscode-azureappservice"      # Azure App Service
    "ms-azuretools.vscode-azurefunctions"       # Azure Functions
    "ms-azuretools.vscode-azureresourcegroups"  # Azure Resource Groups

    # 言語・ローカライゼーション
    "ms-ceintl.vscode-language-pack-ja"         # 日本語言語パック
)

# 各拡張機能をインストール
for extension in "${extensions[@]}"; do
    echo "インストール中: $extension"
    code --install-extension "$extension"
done

echo "すべての拡張機能のインストールが完了しました！"
