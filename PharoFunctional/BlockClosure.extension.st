Extension { #name : #BlockClosure }

{ #category : #'*PharoFunctional' }
BlockClosure >> <+ aBlockOrValue [
	"compose syntax."
	(aBlockOrValue isBlock and: [ aBlockOrValue numArgs >= 1 "to support lazy values"]) 
		"it is a Block"
		ifTrue: [^ [ :aValue | self value: (aBlockOrValue value: aValue) ]  ]
		"it's a value or block with no arguments -lazy value- ."
		ifFalse:[^ self value: aBlockOrValue value ]. 
	
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
