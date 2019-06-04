use draw
use system
use geometry
use flow
import io/[Writer, FileWriter]
import DisplayWriter

Saver: class extends DisplayWriter {
	_writer: Writer
	_filename: String
	init: func (=_filename) {
		super()
	}
	write: override func (pointer: Pointer, length: Int) {
		this _writer write(pointer as Char*, length)
	}
	start: override func (size: IntVector2D, format: String) {
		this _writer = FileWriter new(this _filename, false)
	}
	free: override func() {
		this _writer free()
		super()
	}
}
