# リポジトリを作った時の作業メモ
下記手順で実装した  
```bash
$ docker-compose up -d

$ docker exec -it sqlboiler /bin/sh 
## model生成
$ sqlboiler psql

## 生成したmodelを使って動作させるための準備
$ go get github.com/volatiletech/sqlboiler/v4
$ go get github.com/volatiletech/sqlboiler/v4/drivers/sqlboiler-psql
$ go get github.com/volatiletech/null/v8

## 実行
$ go run cmd/fixed_schema.go
```