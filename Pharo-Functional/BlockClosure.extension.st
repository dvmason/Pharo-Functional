Extension { #name : #BlockClosure }

{ #category : #'*Pharo-Functional' }
BlockClosure >> map: aCollection map: anotherCollection [
	^ aCollection with: anotherCollection collect: self
]
