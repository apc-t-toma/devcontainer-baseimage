#!/bin/bash

# ripgrep インストールスクリプト
# 概要: ripgrep のインストールを行います

set -euo pipefail

echo "🚀 === ripgrep インストール開始 ==="

# 必要なパッケージのインストール
echo "ripgrep をインストール中..."
sudo apt-get install -qq -y \
  ripgrep

echo "✅ ripgrep のインストールが完了しました"

echo "🎉 === ripgrep インストール完了 ==="
