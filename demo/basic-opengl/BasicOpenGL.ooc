use flow
use geometry
use media
use opengl
use utility

main: func (arguments: String[]) {
	context := OpenGLContext new()
	input := Decoder new(arguments[2], IntVector2D parse(arguments[1]))
	last := input as Filter
	last = last connect(ToMonochrome new())
	last = last connect(ToGpu new(context))
	last = last connect(LumaInverter new(context))
	last connect(Displayer new())
	input play()
	exit(1)
}
