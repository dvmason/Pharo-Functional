Extension { #name : #SequenceableCollection }

{ #category : #'*Pharo-Functional' }
SequenceableCollection >> >==< other [
	^ ZippedCollection with: self and: other
]

{ #category : #'*Pharo-Functional' }
SequenceableCollection >> destructiure: aBlock [
	^ aBlock valueWithArguments: self
]

{ #category : #'*Pharo-Functional' }
SequenceableCollection >> zip: aCollection [ 
	^ ZippedCollection new with: self with: aCollection
]
