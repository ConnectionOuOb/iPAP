package sequence

import (
	"fmt"
	"regexp"
	"iPAP/pkg/tool"
)

const (
    AminoAcid = "ACDEFGHIKLMNPQRSTVWY"
)

var Algorithms = []string{
    "SSE-PSSM",
}

type Request struct {
    Method   string `json:"Method"`
    Sequence string `json:"Sequence"`
}

func (Seq *Request) IsValid() bool {
	if Seq.Sequence == "" {
		return false
	}

	RE := regexp.MustCompile(fmt.Sprintf("^[ %s]+$", AminoAcid))

	return RE.MatchString(Seq.Sequence) && tool.InStringSlice(Seq.Method, Algorithms)
}
