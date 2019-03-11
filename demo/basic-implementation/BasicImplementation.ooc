use flow
use geometry
use media

main: func (arguments: String[]) {
	input := Decoder new(arguments[2], IntVector2D parse(arguments[1]))
	last := input as Filter
	last connect(Displayer new())
	input play()
	exit(1)
}
