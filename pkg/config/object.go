package config

type Config struct {
    Version     string `json:"Version"`
    BaseUrl     string `json:"Base_Url"`
    BasePort    string `json:"Base_Port"`
    ApiSequence string `json:"Api_Sequence"`
}
