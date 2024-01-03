package tool

import (
    "time"
    "encoding/hex"
    "crypto/sha256"
)

func SHA256Encode(input string) string {
	hasher := sha256.New()
	hasher.Write([]byte(input))

	return hex.EncodeToString(hasher.Sum(nil))
}

func SHA256EncodeAddTime(input string) string {
    return SHA256Encode(input + time.Now().Format("2006-01-02 15:04:05"))
}
