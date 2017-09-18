use draw
use io
use geometry
use flow

Display: class extends Consumer {
	_process: Process
	_writer: PipeWriter
	init: func {
		super()
	}
	receive: override func (frame: Frame) {
		if (this _process == null)
			this _start(frame data size)
		this _writer write(frame data as RasterYuv420Semiplanar y buffer pointer as CString, frame data size area)
	}
	_start: func (size: IntVector2D) {
		this _process = Process new(["avplay", "-f", "rawvideo", "-pixel_format", "gray", "-video_size", "1920x1080", "-"])
		this _process stdIn = Pipe new()
		this _writer = this _process stdIn writer()
		this _process executeNoWait()
	}
}
