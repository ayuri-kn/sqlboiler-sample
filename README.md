# SQLBoilerでMulti Schemaへのアクセスを試してみる

# 前提環境
前提としている環境は下記です  
※Windowsでも動作すると思うのですが未確認です。ご了承ください  

- macOS 12.5.1
- Docker環境(Docker Desktopなど)

# リポジトリの詳細説明
下記Blogを参照してください  
https://www.ai-shift.co.jp/techblog/3086

# 動作方法
```
## 下記で起動した後、container内に入ってSQLBoilerを試してください
$ docker-compose up -d
$ docker exec -it sqlboiler /bin/sh

## 下記でSQLBoilerでのコード生成を実行してください
$ sqlboiler psql

## 下記コマンドでデータ取得を試すことができます
$ go run cmd/fixed_schema.go
$ go run cmd/multi_schema.go
```