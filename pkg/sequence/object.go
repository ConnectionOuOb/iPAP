package sequence

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
