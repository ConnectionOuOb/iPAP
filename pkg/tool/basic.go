package tool

func InStringSlice(search string, Targets []string) bool {
	for _, target := range Targets {
		if target == search { return true }
	}

	return false
}
