package sequence

import (
	"strings"
	"os/exec"
	"io/ioutil"
)

/*
prg, "-seq", str(seq), "-tdb", tdb,
"-rdb", rdb, "-search", search, "-algo", algo,
"-matrix", matrix, "-threads", str(threads), "-inifile", inifile,
-----------
./bin/ssepssm -seq MISLIAALAVDRVIGMENAMPWNLPADLAWFKRNTL -tdb UniRef25-2015 -rdb NrPdb90-2015 -search psiblast -algo VSH -matrix pssm -threads 8 -inifile bin/ssepssm.ini | grep -vE '^\s*#|^\s*$|^false|^true'
*/

const (
	threads = "4"
	program = "bin/ssepssm"
	inifile = "bin/ssepssm.ini"
)

var ArgsSSEPSSM = map[string][]string{
	"tdb" : []string{
		"UniRef25-2015",
	},
	"rdb" : []string{
		"NrPdb90-2015",
	},
	"search" : []string{
		"psiblast",
	},
	"algo" : []string{
		"VSH",
	},
	"matrix" : []string{
		"pssm",
	},
}

type SSEPSSM struct {
    Sequence   string
	TargetDB   string
	RefernceDB string
	Search 	   string
	Algorithm  string
	OutMatrix  string
}

func (s *SSEPSSM) IsValid() bool {
	return true
}

func (s *SSEPSSM) Run() ([]string, bool) {
	Arguments := []string{
		"-seq", s.Sequence,
		"-tdb", s.TargetDB,
		"-rdb", s.RefernceDB,
		"-search", s.Search,
		"-algo", s.Algorithm,
		"-matrix", s.OutMatrix,
		"-threads", threads,
		"-inifile", inifile,
	}

	cmd := exec.Command(program, Arguments...)

	stdout, _ := cmd.StdoutPipe()

	cmd.Start()

	data, _ := ioutil.ReadAll(stdout)

	cmd.Wait()

	Features := []string{}
	for _, line := range strings.Split(string(data), "\n") {
		if line == "" { continue }
		if strings.HasPrefix(line, "#") { continue }
		if strings.HasPrefix(line, "false") { continue }

		Features = append(Features, line)
	}

	if len(Features) == 0 { return Features, false }

	return Features, true
}
