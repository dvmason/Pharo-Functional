Extension { #name : #Integer }

{ #category : #'*Pharo-Functional' }
Integer >> iota [
	"Answer an Interval from 1 up to the receiver, incrementing by 1."

	^ Interval from: 1 to: self by: 1
]
