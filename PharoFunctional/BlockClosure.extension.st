Extension { #name : #BlockClosure }

{ #category : #'*PharoFunctional' }
BlockClosure >> <*> aBlock [
   | a b |
   a := self numArgsAsBlock.
   b := aBlock numArgsAsBlock.
   (a + b = 3 and: (a min: b) > 0) ifFalse: [ ^ ArityError signal ].
   "This is the backHook from I"
   b = 2 ifTrue: [ 
      ^ [ :x | aBlock value: (self value: x) value: x ] ].
   "This is the S combinator also known as the Starling"
   ^ [ :x | self value: x value: (aBlock value: x) ]
]

{ #category : #'*PharoFunctional' }
BlockClosure >> <-> aBlock [
	| a b |
	a := self numArgsAsBlock.
	b := aBlock numArgsAsBlock.
	(a + b = 3 and: (a min: b) > 0) ifFalse: [ ^ ArityError signal ].
	"This is the D combinator also known as the Dove bird"
	a = 2 ifTrue: [ ^ [ :x :y | self value: x value: (aBlock value: y) ] ].
	^ [ :x :y | aBlock value: (self value: x) value: y ]
]

{ #category : #'*PharoFunctional' }
BlockClosure >> <| aFullBlockClosure [
   (self numArgsAsBlock = 1 and:
       aFullBlockClosure numArgsAsBlock = 1) ifFalse: [ 
      ^ ArityError signal ].
   ^ [ :x | self value: (aFullBlockClosure value: x) ]
]

{ #category : #'*PharoFunctional' }
Symbol >> <|> aBlock [
   | a b |
   a := self numArgsAsBlock.
   b := aBlock numArgsAsBlock.
   (a + b = 3 and: (a min: b) > 0) ifFalse: [ ^ ArityError signal ].
   "Psi or 'over'"
   a = 2 ifTrue: [ 
      ^ [ :x :y | 
        self value: (aBlock value: x) value: (aBlock value: y) ] ].
   "B1 or 'atop'"
   ^ [ :x :y | self value: (aBlock value: x value: y) ]
]

{ #category : #'*PharoFunctional' }
BlockClosure >> curry: anObject [
	^ [: left |  self value: left value: anObject ]
]

{ #category : #'*PharoFunctional' }
BlockClosure >> map: aCollection [

	^ aCollection collect: self
]

{ #category : #'*PharoFunctional' }
BlockClosure >> map: aCollection map: anotherCollection [
	^ aCollection with: anotherCollection collect: self
]

{ #category : #'*PharoFunctional' }
BlockClosure >> numArgsAsBlock [
	^ self numArgs
]

{ #category : #'*PharoFunctional' }
BlockClosure >> |> aBlock [

	"This is the B combinator also known as the Bluebird"

	(self numArgsAsBlock = 1 and: aBlock numArgsAsBlock = 1) 
		ifFalse: [ ^ ArityError signal ].
	^ [ :x | aBlock value: (self value: x) ]
]
