use draw
use flow

Output: class extends Consumer {
	_stream: FStream
	init: func (=_stream) {
		super()
	}
	receive: override func (frame: Frame) {
		this _stream write(frame data as RasterYuv420Semiplanar y buffer pointer as Char*, 0, frame data size area)
	}
}
