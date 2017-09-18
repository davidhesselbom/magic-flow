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
		reader := process stdOut reader()
		process executeNoWait()
		while (reader hasNext()) {
			readCount := 0
			while (byteCount > readCount)
				readCount += reader read(buffer pointer as CString, readCount, byteCount - readCount)
			image := RasterYuv420Semiplanar new(buffer, this _resolution, this _resolution x, this _resolution area)
			this send(Frame new (this _serial, image))
			this _serial += 1
			buffer = ByteBuffer new(byteCount)
		}
		buffer free()
	}
}
