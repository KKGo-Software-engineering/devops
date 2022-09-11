package main

import (
	"database/sql"
	"log"
	"os"

	"github.com/aorjoa-training/devops-go-example/rest/handler"
	"github.com/labstack/echo/v4"

	_ "github.com/lib/pq"
)

func main() {
	connStr := os.Getenv("DB_CONNECTION")
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}

	h := handler.NewApplication(db)

	e := echo.New()
	e.GET("/", h.Greeting)
	// Intentionally, not setup database at this moment so we ignore feature to access database
	// e.GET("/news", h.ListNews)
	serverPort := ":" + os.Getenv("PORT")
	e.Logger.Fatal(e.Start(serverPort))
}
