Extension { #name : #SequenceableCollection }

{ #category : #'*Pharo-Functional' }
SequenceableCollection >> >==< other [
	^ ZippedCollection new with: self with: other
]

{ #category : #'*Pharo-Functional' }
SequenceableCollection >> apply: aBlock [
	^ aBlock argumentCount = self size ifTrue: [
				aBlock valueWithArguments: self
			] ifFalse: [
				aBlock cull: self
			]

]

{ #category : #'*Pharo-Functional' }
SequenceableCollection >> destructure: aBlock [
	^ aBlock valueWithArguments: self
]

{ #category : #'*Pharo-Functional' }
SequenceableCollection >> zip: aCollection [ 
	^ ZippedCollection new with: self with: aCollection
]
