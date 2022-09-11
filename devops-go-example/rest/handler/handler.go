package handler

import (
	"database/sql"
	"log"
	"net/http"

	"github.com/labstack/echo/v4"
)

type handler struct {
	DB *sql.DB
}

func NewApplication(db *sql.DB) *handler {
	return &handler{db}
}

func (h *handler) Greeting(c echo.Context) error {
	return c.String(http.StatusOK, "Hello, World!")
}

type NewsArticle struct {
	ID      int
	Title   string
	Content string
	Author  string
}

func (h *handler) ListNews(c echo.Context) error {
	rows, err := h.DB.Query("SELECT * FROM news_articles")
	if err != nil {
		return err
	}
	defer rows.Close()

	var nn = []NewsArticle{}
	var n = NewsArticle{}

	for rows.Next() {
		err := rows.Scan(&n.ID, &n.Title, &n.Content, &n.Author)
		if err != nil {
			log.Fatal(err)
		}
		nn = append(nn, n)
	}

	return c.JSON(http.StatusOK, nn)
}
