use base
use draw
use geometry
use io
use flow

Input: class extends Producer {
	_serial: ULong = 0
	_resolution: IntVector2D
	_filename: String
	init: func (=_filename, =_resolution) {
		super()
	}
	play: func {
		byteCount := this _resolution area * 1.5
		buffer := ByteBuffer new(byteCount)
		process := Process new(["avconv", "-i", this _filename, "-f", "rawvideo", "-pixel_format", "yuv420p", "-"])
		process stdOut = Pipe new()
		process executeNoWait()
		while (process stdOut read(buffer pointer as CString, byteCount) >= byteCount) {
			image := RasterYuv420Semiplanar new(buffer, this _resolution, this _resolution x, this _resolution area)
			this send(Frame new (this _serial, image))
			this _serial toString() println()
			this _serial += 1
			buffer = ByteBuffer new(byteCount)
		}
		buffer free()
	}
}
