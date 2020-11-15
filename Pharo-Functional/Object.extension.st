Extension { #name : #Object }

{ #category : #'*Pharo-Functional' }
Object >> chain [
	^ ChainMessagesProxy new initializeTargetValue: self
]

{ #category : #'*Pharo-Functional' }
Object >> curry: aBlock [
	^ [: right |  aBlock value: self value: right]
]
