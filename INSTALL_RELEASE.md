# release ブランチのローカルインストール手順

このドキュメントでは、`release` ブランチに含まれる最新の修正（不具合修正や新機能の Hook など）をローカル環境にインストールする手順を説明します。

## 自動インストール

提供されているスクリプトを使用することで、一括でインストールが可能です。

```bash
chmod +x script/install-release.sh
./script/install-release.sh
```

## 手動インストール手順

スクリプトを使用せずに手動で行う場合は、以下の手順に従ってください。

### 1. ブランチの切り替え
最新のリリース用ソースを取得するためにブランチを切り替えます。

```bash
git checkout release
git pull origin release
```

### 2. 依存関係のインストール
プロジェクトルートで依存関係を更新します。

```bash
bun install
```

### 3. ビルド
`packages/opencode` ディレクトリに移動し、バイナリをビルドします。

```bash
cd packages/opencode
bun run build
```

### 4. ローカルリンク（オプション）
開発中のバイナリをシステムの `opencode` コマンドとして利用できるようにリンクします。

```bash
bun link
```

## バージョンの確認
インストール完了後、以下のコマンドでバージョンが正しく更新されているか確認してください。

```bash
opencode --version
```
