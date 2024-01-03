package api

import (
	"fmt"
	"net/http"
	"encoding/json"
	"iPAP/pkg/sequence"
)

func RouterSequence() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", r.Header.Get("Origin"))
		w.Header().Set("Access-Control-Allow-Methods", "POST, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

		switch r.Method {
			case "OPTIONS":
				w.WriteHeader(http.StatusOK)
				return
		
			case "POST" :
				var Seq sequence.Sequ

				err := json.NewDecoder(r.Body).Decode(&Seq)
				if err != nil {
					http.Error(w, "Failed to decode request", http.StatusBadRequest)
					return
				}

				if !Seq.IsValid() {
					http.Error(w, "Invalid sequence", http.StatusBadRequest)
					return
				}

				w.WriteHeader(http.StatusCreated)

			default:
				http.Error(w, "No such method", http.StatusMethodNotAllowed)
		}
	}
}