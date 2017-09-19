use flow

Sinks: abstract class {
	add: func (action: Func(Frame)) -> This {
		_Sinks new(action, this)
	}
	call: abstract func (argument: Frame)
	apply: abstract func (function: Func(Func(Frame)))
	_empty: static This = _Nil new() as This
	new: static func -> This { This _empty }
}
_Sinks: class extends Sinks {
	_head: Func(Frame)
	_tail: Sinks
	head ::= this _head
	tail ::= this _tail
	init: func (=_head, =_tail)
	free: override func {
		(this _head as Closure) free()
		this _tail free()
		super()
	}
	call: override func (argument: Frame) {
		this _tail call(argument)
		this _head(argument)
	}
	apply: override func (callback: Func(Func(Frame))) {
		this _tail apply(callback)
		callback(this _head)
	}
}
_Nil: class extends Sinks {
	init: func
	call: override func (argument: Frame)
	apply: override func (callback: Func(Func(Frame)))
}
