Extension { #name : #Collection }

{ #category : #'*PharoFunctional' }
Collection >> adjacentFind: binaryBlock [
	^ self zipFind: (self allButFirst) with: binaryBlock.
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

{ #category : #'*PharoFunctional' }
Collection >> zipFind: aCollection with: binaryBlock [
   " currently doesn't work if zipFind doesn't find a match"
   ^ self zip: aCollection 
       :> asArray
       :> select: [ :e | binaryBlock value: (e first) value: (e second)]
       :> first.
]
