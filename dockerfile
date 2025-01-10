# ベースイメージ: Ubuntu 22.04 (必要に応じて変更)
FROM ubuntu:22.04

# gh-ost のバージョン (例: v1.1.7) と ダウンロードファイル名
ENV GH_OST_VERSION=1.1.7
ENV GH_OST_DOWNLOAD=gh-ost-binary-linux-arm64-20241219160321.tar.gz

# 必要なパッケージをインストール & gh-ost をダウンロード + インストール
RUN apt-get update \
    && apt-get install -y --no-install-recommends wget ca-certificates tar \
    && rm -rf /var/lib/apt/lists/* \
    \
    # wget で古いバージョンの gh-ost アーカイブをダウンロード
    && wget "https://github.com/github/gh-ost/releases/download/v${GH_OST_VERSION}/${GH_OST_DOWNLOAD}" \
        -O /tmp/gh-ost.tar.gz \
    \
    # tar xzvf で解凍 (解凍後に /tmp/gh-ost が生成される想定)
    && tar xzvf /tmp/gh-ost.tar.gz -C /tmp \
    \
    # バイナリを /usr/local/bin に配置して実行権限付与
    && mv /tmp/gh-ost /usr/local/bin/gh-ost \
    && chmod +x /usr/local/bin/gh-ost \
    \
    # 後片付け
    && rm /tmp/gh-ost.tar.gz

