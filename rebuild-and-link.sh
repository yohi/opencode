#!/bin/bash

# このスクリプトのディレクトリを取得
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_SCRIPT="$REPO_ROOT/packages/opencode/script/build.ts"
BINARY_PATH="$REPO_ROOT/packages/opencode/dist/opencode-linux-x64/bin/opencode"
LINK_PATH="$HOME/.opencode/bin/opencode"

echo "🚀 Starting build and relink process..."

# 1. ビルドの実行
echo "🔨 Building opencode..."
BRANCH_NAME=$(git branch --show-current 2>/dev/null || echo "unknown")
TIMESTAMP=$(date +%Y%m%d%H%M%S)
export OPENCODE_VERSION="${BRANCH_NAME}-${TIMESTAMP}"
bun "$BUILD_SCRIPT" --single

if [ $? -ne 0 ]; then
  echo "❌ Build failed. Aborting."
  exit 1
fi

# 2. シンボリックリンクの更新
echo "🔗 Updating symbolic link..."

# 既存のファイルがシンボリックリンクでない（実体ファイルである）場合はバックアップ
if [ -f "$LINK_PATH" ] && [ ! -L "$LINK_PATH" ]; then
  mv "$LINK_PATH" "${LINK_PATH}.bak"
  echo "📦 Original binary backed up to ${LINK_PATH}.bak"
fi

# シンボリックリンクの作成/更新
ln -sf "$BINARY_PATH" "$LINK_PATH"

echo "✅ Done! You can now use 'opencode' command."
ls -l "$LINK_PATH"
