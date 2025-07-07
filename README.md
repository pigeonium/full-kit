# Pigeonium Full-Kit
この完全なキットは、PigeoniumのpythonライブラリとAPIサーバー、Webエクスプローラー、それらを簡単にセットアップできるDocker関連のファイルを提供します。

## セットアップ (Docker)

1.  DockerとDocker Composeがインストールされていることを確認してください。
2.  リポジトリをクローンします。
    ```bash
    git clone --recursive https://github.com/pigeonium/full-kit.git
    cd full-kit
    ```
3.  Dockerコンテナをビルドして起動します。
    ```bash
    docker-compose up -d --build
    ```

コンテナが起動すると、以下のサービスが利用可能になります。

  * **Webエクスプローラー**: `http://localhost:8080`
  * **APIサーバー**: `http://localhost:14540`

ネットワークの詳細な設定は`api.Dockerfile`を編集することで変更できます。

## プロジェクト構成

```
.
├── api.Dockerfile          # APIサーバー用Dockerfile
├── docker-compose.yml      # Docker Compose設定ファイル
├── explorer.Dockerfile     # Webエクスプローラー用Dockerfile
├── nginx.conf              # Nginx設定ファイル
├── pigeonium/              # Pigeoniumコアライブラリ
├── server/                 # APIサーバー
│   ├── api.py              # APIエンドポイント定義
│   ├── api_types.py        # APIデータ型定義
│   ├── config.py           # サーバー設定
│   ├── main.py             # FastAPIアプリケーションのエントリーポイント
│   ├── pigeonium.sql       # 初期データベーススキーマ
│   └── pigeonium/          # Pigeoniumコアライブラリ (サーバー用)
└── web_explorer/           # Webフロントエンド
    ├── address.html        # アドレス詳細ページ
    ├── contract.html       # コントラクト詳細ページ
    ├── currency.html       # 通貨詳細ページ
    ├── explorer.html       # メインのエクスプローラーページ
    ├── index.html          # トップページ
    ├── transaction.html    # トランザクション詳細ページ
    ├── univ.css            # 共通スタイルシート
    └── univ.js             # 共通JavaScript
```

## API

APIの仕様はFastAPIによって自動生成されるSwagger UI (`http://localhost:14540/docs`) またはRedoc (`http://localhost:14540/redoc`) で確認できます。

主なエンドポイントは以下の通りです。

  * `GET /`: ネットワーク情報を取得
  * `GET /currency/{currencyId}`: 通貨情報を取得
  * `GET /balances/{address}`: アドレスの残高を取得
  * `GET /transaction/{indexId}`: トランザクションを取得
  * `POST /transaction`: トランザクションをブロードキャスト
  * `POST /contract`: スマートコントラクトをデプロイ
