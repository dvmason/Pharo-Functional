Extension { #name : #Object }

{ #category : #'*PharoFunctional' }
Object >> +> aBlock [ 
	"pipe : pass value to function (reverse compose) ."
  ^ self pipeTo: aBlock.
]

{ #category : #'*PharoFunctional' }
Object >> ,+ anObject [
	"haskell like pair syntax. "
	^ self asPairWith: anObject . 
	 
]

{ #category : #'*PharoFunctional' }
Object >> @@ aBlock [ 
  ^ self curry: aBlock
]

{ #category : #'*PharoFunctional' }
Object >> asPairWith: anObject [
	^ Pair with: self with: anObject .
]

{ #category : #'*PharoFunctional' }
Object >> chain [
	^ ChainMessagesProxy new initializeTargetValue: self
]

{ #category : #'*PharoFunctional' }
Object >> curry: aBlock [
	^ [: right |  aBlock value: self value: right]
]

{ #category : #'*PharoFunctional' }
Object >> emptyOrNilOr: aBlock [
	^ aBlock value: self
]

{ #category : #'*PharoFunctional' }
Object >> nilOr: aBlock [
	^ aBlock value: self
]

{ #category : #'*PharoFunctional' }
Object >> pipeTo: aBlock [ 
	"pipe : pass value to function ."
	"see : +>"
  	^ aBlock value: self value.
]
