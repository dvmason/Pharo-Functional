"
I support (,Clean,Full}BlockClosureCurryable which are just like their superclass, but their value* methods handle too few arguments by currying the values.

This is from an idea from Boris Shingarov who has a [related implementation](https://github.com/shingarov/MachineArithmetic/blob/pure-z3/src/PreSmalltalks-Pharo/BlockClosure.extension.st)

This could be implemented directly in the original classes, except:
1. that would modify the base Pharo code
2. the resulting error messages could be misleading
"
Trait {
	#name : #BlockClosureCurryTrait,
	#category : #'PharoFunctional-Kernel'
}

{ #category : #accessing }
BlockClosureCurryTrait >> value: firstArg [

	<primitive: 207>
	self numArgs > 1 ifTrue: [ ^ [ :x | self value: firstArg value: x ] ].
	self primitiveFailed
]
