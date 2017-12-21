use flow

Producer: abstract class extends Filter {
	init: func {
		super(1)
	}
	send: func ~default (frame: Frame) {
		//frame debug("producer before increase")
		frame increaseReferenceCount()
		//frame debug("producer before send")
		this send(0, frame)
	}
}
