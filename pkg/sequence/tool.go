package sequence

import (
	"fmt"
	"regexp"
)

func (Seq *Sequ) IsValid() bool {
	if Seq.Sequence == "" {
		return false
	}

	RE := regexp.MustCompile(fmt.Sprintf("^[ %s]+$", AminoAcid))

	return RE.MatchString(Seq.Sequence)
}