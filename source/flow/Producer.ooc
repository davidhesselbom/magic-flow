use flow

Producer: abstract class extends Filter {
	init: func {
		super(1)
	}
	send: func ~default (frame: Frame) {
		this send(0, frame)
	}
}
