# Buzzcord(バズコード)

<img src="https://user-images.githubusercontent.com/82434093/173498596-464c8f4c-3e7c-40aa-95b1-1ad55d821cfb.svg" width="50%">

### 昨日 Discord サーバー内でバズった発言、「Buzzcord ランキング」をチェックしよう！

**Buzzcord**は、Discord の所属サーバー内で昨日、1 番バズった発言(→ バズコード)を DiscordBot が自動で集計を行い、毎日決まった時間に第 1 位をお知らせ投稿にて紹介してくれるサービスです。

- 「バズった」とは?
  - Discord に投稿された発言がたくさんの人に注目されて【絵文字スタンプが多く押された】こと

## 特徴

- Buzzcord のお知らせによって、Discord 内のチャンネル数が多くて全てを見て回るのが難しいときでも、昨日みんなが一番絵文字スタンプで反応した発言を簡単に知ることができます。

- web サイトでは、昨日の 1 番だけでなく Buzzcord ランキングベスト 5 を知ることができます。

## 開発環境

- Ruby 3.1.0
- Rails 6.1.6

## 機能概要

### DiscordBot の動き

- DiscordBot がサーバー内に常駐し、公開されているテキストチャンネル内で投稿に対して付加・削除された絵文字スタンプでのリアクションを収集します。
- 集められたデータは日付が変わった後に前日 1 日分を集計、ランキング情報を作成します。
- 毎日決まった時間に、設定した Discord のチャンネルに第 1 位の発言のご紹介を投稿します。
- ユーザー登録情報の変更があった際にはサービス内のユーザー情報も同期して更新します。

### Web サイト

- Bot を設定しているサーバーの前日の Buzzcord ランキング 1〜5 位の発言をご覧いただけます。
- Bot を設定したサーバーのメンバーのみがログインできます。
- サーバーから去ったメンバーは自動的にこのサービスから削除されます。

## 利用方法

### Discord の Application の作成

https://discordapp.com/developers/applications/

#### Bot の設定

- Developer Portal から Bot を作成して Token を環境変数に設定する
- SERVER MEMBERS INTENT を ON にする
- OAuth2 の Scope から Bot をチェック、Permissions の SendMessages をチェックする
- 発行された URL から Bot をサーバーに招待する

#### OAuth2 の設定

- Developer Portal の OAuth2 の Redirects にリダイレクト URL を設定する
- OAuth2 の Client ID と Client Secret を環境変数に設定する
- 利用 Scope は identify のみにチェックする

### 環境変数の設定

| 環境変数名            | 説明                                              |
| --------------------- | ------------------------------------------------- |
| DISCORD_BOT_TOKEN     | Bot の Token                                      |
| DISCORD_SERVER_ID     | Bot を招待し、活動させる Discord サーバーの ID    |
| DISCORD_CLIENT_ID     | OAuth2 の Client ID                               |
| DISCORD_CLIENT_SECRET | OAuth2 の Client Secret                           |
| DISCORD_CHANNEL_ID    | Bot からのお知らせ投稿を送信したいチャンネルの ID |
| URL_HOST              | ローカルの場合は`127.0.0.1:3000`                  |

Discord の個人設定の詳細設定から開発者モードを ON にすると、サーバーやチャンネルの ID を取得できるようになります。

### インストール

```bash
$ bin/setup
$ bin/rails server
$ bin/webpack-dev-server
```

### Rake Task

- `bin/rails discord_bot:start`で Bot をオンライン状態にして活動をスタートさせます。Heroku で動かす際は Dynos に表示されるこのコマンドを ON にしてください。

  - 🚨 絵文字スタンプ情報の収集やユーザーの自動削除更新機能は Bot をオンライン状態にしていないと機能しません。Heroku の無料枠で利用している場合は一定期間活動がないと Bot がスリープ状態になってしまうようなので、Heroku Scheduler で 10 分おきにアクセスするなどで対応をお願いします。

- `bin/rails ranks:create`を実行することによって、前日分のデータを集計し、ランキング情報を作成します。

  - 🚨Heroku で動かす際は Heroku Scheduler にこのコマンドを登録してください。

- `bin/rails ranks:post_buzzcord `を実行することによって、Discord 内の指定したチャンネルに Buzzcord ランキング第 1 位のお知らせを投稿します。
  - 🚨Heroku で動かす際は Heroku Scheduler にこのコマンドを登録してください。

## テスト

```bash
$ bundle exec rspec
```

## ScreenShots

- Discord の発言に押された絵文字スタンプ数を bot が毎日自動で収集&集計します。(発言の下に並んでいるのが絵文字スタンプです。)

![discord_example](https://user-images.githubusercontent.com/82434093/173518163-30aa5f61-97e4-4cce-b039-9959d862c439.png)

- 毎日定時に、前日のランキング第 1 位を Discord でお知らせします。

<img src="https://user-images.githubusercontent.com/82434093/173498917-f14cb58b-0240-409c-ad9a-c4b5c1e3ebdc.png" width="50%">

- Web サイトにログインすると前日のランキング第 1 位〜5 位がチェックできます。

左:ログイン前、右:ログイン後

![スクリーンショット 2022-06-14 16 58 11](https://user-images.githubusercontent.com/82434093/173525062-18704182-32d6-471a-b101-8aa9a7ae9d0c.png)
