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

# 5. ~/.local/bin/opencode のリンクを開発版に更新
OS=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  ARCH="x64"
elif [ "$ARCH" = "aarch64" ]; then
  ARCH="arm64"
fi

BINARY_NAME="opencode-${OS}-${ARCH}"
BINARY_PATH="$(pwd)/dist/${BINARY_NAME}/bin/opencode"

if [ -f "$BINARY_PATH" ]; then
  echo "🔗 ~/.local/bin/opencode のリンクを開発版（${BINARY_NAME}）に更新しています..."
  mkdir -p ~/.local/bin
  ln -sf "$BINARY_PATH" ~/.local/bin/opencode
else
  echo "⚠️  開発版バイナリが見つかりませんでした: $BINARY_PATH"
fi

echo "✅ インストールが完了しました！"
echo "バージョン確認:"
opencode --version

