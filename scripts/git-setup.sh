#!/bin/bash

# Git セットアップスクリプト
# 概要: Gitの設定とgit-lfsのセットアップを行います

set -euo pipefail

echo "🚀 === Git セットアップ開始 ==="

# 必要なパッケージのインストール
echo "必要なパッケージをインストール中..."
sudo apt-get install -qq -y \
  git \
  gnupg \
  rsync

# ホストの.gitconfigファイルの確認とコピー
if [ -f /tmp/import/.gitconfig ] && [ -s /tmp/import/.gitconfig ]; then
  echo "ホストの.gitconfigファイルが見つかりました。コピー中..."
  rsync -aqz /tmp/import/.gitconfig ~/.gitconfig
  echo "✅ ホストの.gitconfigファイルをコピーしました"
else
  echo "Gitグローバル設定を適用中..."
  echo "メール: $GIT_USER_EMAIL"
  echo "名前: $GIT_USER_NAME"

  # gitの設定
  git config --global core.autocrlf false
  git config --global core.editor "code --wait"
  git config --global core.fscache true
  git config --global core.quotepath false
  git config --global core.symlinks false
  git config --global fetch.prune true
  git config --global fetch.pruneTags true
  git config --global init.defaultBranch main
  git config --global pull.rebase true
  git config --global user.email "$GIT_USER_EMAIL"
  git config --global user.name "$GIT_USER_NAME"

  if [ -d ~/.gnupg ]; then
    # GPG署名キーの取得と設定
    echo "GPG署名キーを取得中..."
    GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format=long --with-colons | grep '^sec:' | head -n1 | cut -d':' -f5)
    echo "GPG署名キーID: $GPG_KEY_ID"
    git config --global commit.gpgsign true
    git config --global user.signingkey "$GPG_KEY_ID"
    echo "✅ GPG署名キーを設定しました"
  else
    echo "⚠️  ~/.gnupgディレクトリが見つかりませんでした、GPG署名キーの設定をスキップします"
  fi

  echo "✅ Git セットアップが完了しました"
fi

echo "🎉 === Git セットアップ完了 ==="
