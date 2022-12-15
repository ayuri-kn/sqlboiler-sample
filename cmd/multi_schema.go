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
		"host=sqlboiler-postgres dbname=db user=usr password=password sslmode=disable")

	schemas := []string{"schema1", "schema2"}
	for _, schema := range schemas {
		books, _ := models.BooksWithSchema(schema).All(context.Background(), db)
		for i, book := range books {
			fmt.Printf("[findAll] %s.book[%d]:%v\n", schema, i, book)
		}
	}

	for _, schema := range schemas {
		book, _ := models.FindBookWithSchema(context.Background(), db, schema, 1)
		fmt.Printf("[find] %s.book[1]:%v\n", schema, book)
	}
}
