# Pigeonium Full-Kit

Pigeoniumは、独自の資産「Pigeon」を基軸通貨とする、シンプルで拡張性の高いブロックチェーンプラットフォームです。  
ユーザーはウォレットの作成、残高の確認、トランザクションの送受信、そしてスマートコントラクトの展開と実行が可能です。

## 主な特徴

  * **基軸通貨**: "Pigeon" (Pigeon) という名前のネイティブ通貨が使用されます。
  * **ウォレット**: ECDSA署名に基づいた安全なウォレットを生成・管理できます。
  * **スマートコントラクト**: Pythonベースのスクリプト言語で記述されたスマートコントラクトをブロックチェーン上にデプロイし、自動化された取引やロジックを実行できます。
  * **データベース**: トランザクション、残高、コントラクトなどのデータはMySQLデータベースで効率的に管理されます。
  * **APIサーバー**: FastAPIで構築されたAPIサーバーを介して、外部アプリケーションとシームレスに連携できます。
  * **Webエクスプローラー**: トランザクション、アドレス、通貨、コントラクトの情報をリアルタイムで確認できるWebインターフェースが付属します。

## セットアップ

1.  DockerとDocker Composeがインストールされていることを確認してください。
2.  リポジトリをクローンします。
    ```bash
    git clone https://github.com/pigeonium/full-kit.git
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
│   ├── __init__.py         #
│   ├── config.py           #
│   ├── contract.py         #
│   ├── currency.py         #
│   ├── error.py            #
│   ├── state.py            #
│   ├── struct.py           #
│   ├── transaction.py      #
│   ├── utils.py            #
│   └── wallet.py           #
├── pigeonium.sql           # 初期データベーススキーマ
├── server/                 # APIサーバー
│   ├── api.py              # APIエンドポイント定義
│   ├── api_types.py        # APIデータ型定義
│   ├── config.py           # サーバー設定
│   ├── main.py             # FastAPIアプリケーションのエントリーポイント
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
