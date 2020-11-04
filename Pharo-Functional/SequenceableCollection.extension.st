Extension { #name : #SequenceableCollection }

{ #category : #'*Pharo-Functional' }
SequenceableCollection >> >==< other [
	^ ZippedCollection new with: self with: other
]

{ #category : #'*Pharo-Functional' }
SequenceableCollection >> destructure: aBlock [
	^ aBlock valueWithArguments: self
]

{ #category : #'*Pharo-Functional' }
SequenceableCollection >> groupByRuns2Arg: aBlock [
	"Answer a new collection of the same species as the receiver with elements being collections (of the receiver species) containing those elements of the receiver for which the given block applied to 2 consecutive values evaluates to true."

	"(#(1 2 3 4 4 1 1) groupByRuns2Arg: [ :l :r | l = r]) >>> #((1) (2) (3) (4 4) (1 1))"

	"(#(1 2 3 4 1 2 3 3 4 5 1 ) groupByRuns2Arg: #<=) >>> #((1 2 3 4) (1 2 3 3 4 5) (1))"

	| str eStr compare prev |
	str := Array new writeStream.
	prev := nil.
	compare := false.
	eStr := Array new writeStream.
	self do: [ :e |
			(compare and: [ aBlock value: prev value: e ]) ifFalse: [
					eStr isEmpty ifFalse: [
						str nextPut: (eStr contents as: self species).
						eStr reset ] ].
			eStr nextPut: e.
			compare := true.
			prev := e.
	].
	eStr isEmpty ifFalse: [ str nextPut: (eStr contents as: self species) ].
	^ str contents as: self species
]

{ #category : #'*Pharo-Functional' }
SequenceableCollection >> zip: aCollection [ 
	^ ZippedCollection new with: self with: aCollection
]
