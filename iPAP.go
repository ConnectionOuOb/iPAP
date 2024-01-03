package main

import (
	"log"
	"iPAP/pkg/api"
	"iPAP/pkg/config"
)

func main() {
    log.Println("### iPAP start")

	var config config.Config

	log.Println("### Load config")
	isOK, msg := config.Load()
	if !isOK { log.Fatal("### Error: " + msg + "\n") }

	log.Println("### Create router")
	api.CreateRouter(config)
}