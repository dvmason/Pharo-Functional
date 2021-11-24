Extension { #name : #BlockClosure }

{ #category : #'*PharoFunctional' }
BlockClosure >> <+ aValue [
	"compose syntax."
	^ self value: aValue.
]

{ #category : #'*PharoFunctional' }
BlockClosure >> <<+ aCollection [
	"destructure syntax."
	^ self valueWithArguments: aCollection .
]

{ #category : #'*PharoFunctional' }
BlockClosure >> curry: anObject [
	^ [: left |  self value: left value: anObject ]
]

{ #category : #'*PharoFunctional' }
BlockClosure >> map: aCollection map: anotherCollection [
	^ aCollection with: anotherCollection collect: self
]
