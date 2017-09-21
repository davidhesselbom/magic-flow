use draw
use draw-gpu
use io
use geometry
use flow

import DisplayWriter

Displayer: class extends DisplayWriter {
	_process: Process
	_writer: PipeWriter
	init: func {
		super()
	}
	write: override func (pointer: Pointer, length: Int) {
		this _writer write(pointer as CString, length)
	}
	start: override func (size: IntVector2D, format: String) {
		this _process = Process new(["avplay", "-f", "rawvideo", "-pixel_format", format, "-video_size", size x toString() + "x" + size y toString(), "-i", "-"])
		this _process stdIn = Pipe new()
		this _writer = this _process stdIn writer()
		this _process executeNoWait()
	}
}
