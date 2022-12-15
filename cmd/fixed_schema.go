package main

import (
	"context"
	"database/sql"
	"fmt"

	"github.com/ayuri-kn/sqlboiler-sample/models"

	_ "github.com/lib/pq"
)

func main() {
	db, _ := sql.Open(
		"postgres",
		"host=sqlboiler-postgres dbname=db user=usr password=password search_path=schema1 sslmode=disable")
	books, _ := models.Books().All(context.Background(), db)
	for i, book := range books {
		fmt.Printf("book[%d]:%v\n", i, book)
	}
}
