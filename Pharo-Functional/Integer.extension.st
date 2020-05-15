Extension { #name : #Integer }

{ #category : #'*Pharo-Functional' }
Integer >> iota [
	"Answer an Interval from 1 up to the receiver, incrementing by 1."

	^ Interval from: 1 to: self by: 1
]

{ #category : #'*Pharo-Functional' }
Integer >> iota: aBlock [
	"Answer an Array of the results of the block applied to self iots - equivalent to `self iota collect: aBlock`"
	| result |
	result := Array new: self.
	1 to: self do: [: i | result at: i put: (aBlock value: i) ].
	^ result
]
