Extension { #name : #Object }

{ #category : #'*PharoFunctional' }
Object >> @@ aBlock [ 
  ^ self curry: aBlock
]

{ #category : #'*PharoFunctional' }
Object >> chain [
	^ ChainMessagesProxy new initializeTargetValue: self
]

{ #category : #'*PharoFunctional' }
Object >> curry: aBlock [
	^ [: right |  aBlock value: self value: right]
]
