package main
//go:generate swagger generate spec

import (
	"fmt"
	"github.com/gorilla/mux"
	"github.com/nikhilbhide/JWTDemo/bo"
	_ "github.com/nikhilbhide/JWTDemo/docs"
	"github.com/nikhilbhide/JWTDemo/driver/postgres"
	"github.com/nikhilbhide/JWTDemo/repository/users"
	"github.com/nikhilbhide/JWTDemo/services/registry"
	"github.com/nikhilbhide/JWTDemo/utility"
	"log"
	"net/http"
)

func main() {
	router := mux.NewRouter()

	//instantiate handlers and dbinstance
	//for relevant handlers use JWTMiddleware
	db:= postgres.InitDB("postgres://nenyejsk:80PuDCmjzIAlMJb8xLaS7rgBwE7gXHeN@rajje.db.elephantsql.com:5432/nenyejsk")
	signUpRepo := users.NewLoginPostGresRepo(db)
	signUpUseCase:=bo.NewLoginUseCase(signUpRepo)


	router.HandleFunc("/signupv1",registry.SignUpHandlerV1).Methods("POST")
	router.HandleFunc("/signupv2",registry.SignUpHandlerV2).Methods("POST")
	router.HandleFunc("/signupv3",registry.SignUpHandlerV3).Methods("POST")
	router.HandleFunc("/signupv3",registry.SignUpHandlerV3).Methods("POST")
	registry.NewLoginHandler(router,signUpUseCase)

	ip:=utility.GetIpAddress()
	port:="8080"
	fmt.Printf("Hosting service on IP address %s on port %s",ip,port)
	log.Fatal(http.ListenAndServe( ip+":8081", router))
}