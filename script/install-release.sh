#!/usr/bin/env bash

# releaseブランチの最新修正をローカルにインストールするスクリプト
# 使い方: ./script/install-release.sh

set -e

echo "🚀 releaseブランチのインストールを開始します..."

# 1. ブランチの切り替え
echo "📦 releaseブランチに切り替えています..."
git checkout release
git pull origin release

# 2. 依存関係のインストール
echo "📥 依存関係をインストールしています..."
bun install

# 3. ビルド
echo "🛠️  opencodeパッケージをビルドしています..."
cd packages/opencode
bun run build

# 4. ローカルリンク
echo "🔗 ローカルリンクを作成しています..."
bun link

echo "✅ インストールが完了しました！"
echo "バージョン確認:"
opencode --version
