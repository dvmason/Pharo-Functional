Extension { #name : #Collection }

{ #category : #'*Pharo-Functional' }
Collection >> scan: aBlock [
	| accumulator first |
	first := true.
	^ self collect: [:each |
		first ifTrue: [
			first := false. accumulator := each
		] ifFalse: [
			accumulator := aBlock value: accumulator value: each
		]]
]
