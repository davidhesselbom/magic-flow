use draw
use draw-gpu
use io
use geometry
use flow

Displayer: class extends Consumer {
	_process: Process
	_writer: PipeWriter
	init: func {
		super()
	}
	receive: override func (frame: Frame) {
		this _write(frame data)
	}
	_write: func (image: Image) {
		match(image) {
			case gpuMonochrome: GpuImage =>
				this _write(gpuMonochrome toRaster())
			case cpuMonochrome: RasterMonochrome =>
				if (this _process == null)
					this _start(cpuMonochrome size, "gray")
				this _writer write(cpuMonochrome buffer pointer as CString, cpuMonochrome size area)
			case coloredImage: RasterYuv420Semiplanar =>
				if (this _process == null)
					this _start(coloredImage size, "yuv420p")
				this _writer write(coloredImage as RasterYuv420Semiplanar y buffer pointer as CString, coloredImage size area)
				this _writer write(coloredImage as RasterYuv420Semiplanar uv buffer pointer as CString, coloredImage size area / 2)
		}
	}
	_start: func (size: IntVector2D, format: String) {
		this _process = Process new(["avplay", "-f", "rawvideo", "-pixel_format", format, "-video_size", size x toString() + "x" + size y toString(), "-i", "-"])
		this _process stdIn = Pipe new()
		this _writer = this _process stdIn writer()
		this _process executeNoWait()
	}
}
