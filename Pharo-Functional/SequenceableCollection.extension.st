Extension { #name : #SequenceableCollection }

{ #category : #'*Pharo-Functional' }
SequenceableCollection >> >==< other [
	^ ZippedCollection with: self and: other
]
