Extension { #name : #Collection }

{ #category : #'*PharoFunctional' }
Collection >> emptyOrNilOr: aBlock [
	self isEmpty ifTrue: [ ^ nil ].
	^ aBlock value: self
]

{ #category : #'*PharoFunctional' }
Collection >> frequencies [
	^ self asBag valuesAndCounts.
]

{ #category : #'*PharoFunctional' }
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
