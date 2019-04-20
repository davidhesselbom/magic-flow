use draw
use draw-gpu
use io
use geometry
use flow

import DisplayWriter

Displayer: class extends DisplayWriter {
	_process: Process
	_writer: PipeWriter
	_fps: UInt
	init: func (fps := 25) {
		_fps = fps
		super()
	}
	write: override func (pointer: Pointer, length: Int) {
		this _writer write(pointer as CString, length)
	}
	start: override func (size: IntVector2D, format: String) {
		this _process = Process new(["avplay", "-hide_banner", "-loglevel", "panic", "-f", "rawvideo", "-pixel_format", format, "-framerate", _fps toString(), "-video_size", size x toString() + "x" + size y toString(), "-i", "-"])
		this _process stdIn = Pipe new()
		this _writer = this _process stdIn writer()
		this _process executeNoWait()
	}
	free: override func () {
		_process kill()
		super()
	}
}
