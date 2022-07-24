package main

import (
	"testmaster/user_service"

	"github.com/labstack/echo"
)

func main() {
	e := echo.New()

	// Routes
	e.POST("/users", user_service.CreateUser)
	e.GET("/users/:id", user_service.GetUser)
	e.PUT("/users/:id", user_service.UpdateUser)
	e.DELETE("/users/:id", user_service.DeleteUser)

	// Start server at localhost:1323
	e.Logger.Fatal(e.Start(":1323"))
}
