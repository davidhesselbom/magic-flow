use base
use draw
use geometry
use flow

Input: class extends Producer {
	_serial: ULong = 0
	_resolution: IntVector2D
	_stream: FStream
	init: func (=_stream, =_resolution) {
		super()
	}
	play: func {
		byteCount := this _resolution area * 1.5
		buffer := ByteBuffer new(byteCount)
		while (this _stream read(buffer pointer as Pointer, byteCount) == byteCount) {
			image := RasterYuv420Semiplanar new(buffer, this _resolution, this _resolution x, this _resolution area)
			this send(Frame new (this _serial, image))
			this _serial += 1
			buffer = ByteBuffer new(byteCount)
		}
		buffer free()
	}
}
