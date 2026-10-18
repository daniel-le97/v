module main

import foo
import bar

struct Flag {
	name string
}

// A `[]Flag` formatted inside module foo names its own struct. Module bar also
// declares an enum `Flag`, so the bare element spelling must not resolve to it.
fn test_array_of_struct_interpolation_keeps_the_declaring_module() {
	assert foo.show([]) == '[]'
	text := foo.show([foo.Flag{ name: 'a' }])
	assert text.contains("name: 'a'")
}

// The same rule applies to a struct declared by module main.
fn test_main_module_array_of_struct_interpolation() {
	assert '${[]Flag{}}' == '[]'
	assert '${[Flag{ name: 'b' }]}'.contains("name: 'b'")
}

fn test_error_interpolation_of_the_same_array() {
	foo.get([], 'x') or {
		assert err.msg().contains('not found in []')
		return
	}
	assert false
}

fn test_enum_interpolation_still_works() {
	assert '${bar.Flag.has_accept}' == 'has_accept'
}
