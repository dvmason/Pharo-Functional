Extension { #name : #BlockClosure }

{ #category : #'*PharoFunctional' }
BlockClosure >> curry: anObject [
	^ [: left |  self value: left value: anObject ]
]

{ #category : #'*PharoFunctional' }
BlockClosure >> map: aCollection map: anotherCollection [
	^ aCollection with: anotherCollection collect: self
]
