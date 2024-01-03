package config

import (
    "os"
    "io/ioutil"
    "encoding/json"
    "path/filepath"
    "github.com/akamensky/argparse"
)

func (config *Config) Load() (bool, string) {
    cmd := argparse.NewParser(filepath.Base(os.Args[0]), "# Input a json config file")
    cfg := cmd.String("i", "config-file", &argparse.Options{
        Required: true,
        Help: "Path to json config file"})
	err := cmd.Parse(os.Args)

    if err != nil { return false, cmd.Usage(err) }

    if _, err := os.Stat(*cfg);  err != nil { return false, "File not exists" }

    jsonConfig, err := os.Open(*cfg)
    if err != nil { return false, "Cannot open json file" }
    defer jsonConfig.Close()

    FileBytes, _ := ioutil.ReadAll(jsonConfig)

    json.Unmarshal(FileBytes, &config)

    return true, "success"
}
