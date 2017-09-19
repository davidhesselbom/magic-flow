use draw
use system
use geometry
use flow
import io/[Writer, FileWriter]

Save: class extends Consumer {
	_writer: Writer
	_filename: String
	init: func (=_filename) {
		super()
	}
	receive: override func (frame: Frame) {
		if (this _writer == null)
			this _start(frame data size)
		this _writer write(frame data as RasterYuv420Semiplanar y buffer pointer as Char*, frame data size area)
		this _writer write(frame data as RasterYuv420Semiplanar uv buffer pointer as Char*, frame data size area / 2)
	}
	_start: func (size: IntVector2D) {
		this _writer = FileWriter new(this _filename, false)
	}
}
