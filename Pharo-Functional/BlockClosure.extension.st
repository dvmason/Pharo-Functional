Extension { #name : #BlockClosure }

{ #category : #'*Pharo-Functional' }
BlockClosure >> curry: anObject [
	^ [: left |  self value: left value: anObject ]
]

{ #category : #'*Pharo-Functional' }
BlockClosure >> map: aCollection map: anotherCollection [
	^ aCollection with: anotherCollection collect: self
]
