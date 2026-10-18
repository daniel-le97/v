module foo

pub struct Flag {
pub:
	name string
}

// The element spelling `Flag` must stay `foo.Flag` while formatting `[]Flag`, even
// though module bar declares an enum with the same short name.
pub fn show(flags []Flag) string {
	return '${flags}'
}

pub fn get(flags []Flag, name string) !Flag {
	for flag in flags {
		if flag.name == name {
			return flag
		}
	}
	return error('Flag `${name}` not found in ${flags}')
}
