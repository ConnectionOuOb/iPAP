package api

import (
	"fmt"
	"net/http"
	"iPAP/pkg/config"
)

func CreateRouter(cfg config.Config) {
	uri := fmt.Sprintf("/api/v%s/", cfg.Version)
	http.HandleFunc(uri + cfg.ApiSequence, RouterSequence())

	http.ListenAndServe(cfg.BaseUrl + ":" + cfg.BasePort, nil)
}