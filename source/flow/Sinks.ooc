use flow

Sinks: class {
	_head: Func(Frame)
	_tail: This
	head ::= this _head
	tail ::= this _tail
	init: func ~nil {
		this init(func (argument: Frame))
	}
	init: func (=_head)
	init: func ~add (=_head, =_tail)
	free: override func {
		(this _head as Closure) free()
		if (this _tail != null)
			this _tail free()
		super()
	}
	add: func (action: Func(Frame)) -> This {
		this add(This new(action, null))
	}
	add: func ~withEvent (event: This) -> This {
		if (event)
			if (this _tail)
				this _tail add(event)
			else
				this _tail = event
		this
	}
	call: func (argument: Frame) {
		if (this _tail != null)
			this _tail call(argument)
		this _head(argument)
	}
}
