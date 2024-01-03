package sequence

import (
	"fmt"
	"regexp"
	"iPAP/pkg/tool"
)

func (Seq *Request) IsValid() bool {
	if Seq.Sequence == "" {
		return false
	}

	RE := regexp.MustCompile(fmt.Sprintf("^[ %s]+$", AminoAcid))

	return RE.MatchString(Seq.Sequence) && tool.InStringSlice(Seq.Method, Algorithms)
}