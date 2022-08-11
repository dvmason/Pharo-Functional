Extension { #name : #Symbol }

{ #category : #'*PharoFunctional' }
Symbol >> <*> aBlock [
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
Symbol >> <-> aBlock [
   | a b |
   a := self numArgsAsBlock.
   b := aBlock numArgsAsBlock.
   (a + b = 3 and: (a min: b) > 0) ifFalse: [ ^ ArityError signal ].
   "This is the D combinator also known as the Dove bird"
   a = 2 ifTrue: [ ^ [ : x : y | self value: x value: (aBlock value: y) ] ].
   ^ [ : x : y | aBlock value: (self value: x) value: y ]
]

{ #category : #'*PharoFunctional' }
Symbol >> <| aBlock [
   "This is the Q combinator known as the Queer Bird"
   (self numArgsAsBlock = 1 and:
       aBlock numArgsAsBlock = 1) ifFalse: [ 
      ^ ArityError signal ].
   ^ [ :x | self value: (aBlock value: x) ]
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
Symbol >> argumentCount [
	^ self numArgs + 1
]

{ #category : #'*PharoFunctional' }
Symbol >> cull: firstArg cull: secondArg [
	"Execute the receiver with one or two arguments depending on the receiver"
	"(#negated cull: 13 cull: 12)
	>>> -13
	"
	"(#+ cull: 3 cull: 2)
	>>> 5
	"
	^ self numArgs < 1 
		ifTrue: [self cull: firstArg]
		ifFalse: [self value: firstArg value: secondArg]
	
]

{ #category : #'*PharoFunctional' }
Symbol >> cull: firstArg cull: secondArg cull: thirdArg [
	"Execute the receiver with one or two arguments depending on the receiver"
	"(#negated cull: 13 cull: 12 cull: 17)
	>>> -13
	"
	"(#+ cull: 3 cull: 2 cull: 17)
	>>> 5
	"
	"(#closeTo:precision: cull: 3 cull: 2 cull: 17)
	>>> false
	"
	^ self numArgs < 2
		ifTrue: [self cull: firstArg cull: secondArg]
		ifFalse: [self value: firstArg value: secondArg value: thirdArg]
]

{ #category : #'*PharoFunctional' }
Symbol >> cull: firstArg cull: secondArg cull: thirdArg cull: fourthArg [
	"Execute the receiver with one or two arguments depending on the receiver"
	"(#negated cull: 13 cull: 12 cull: 17 cull:92)
	>>> -13
	"
	"(#+ cull: 3 cull: 2 cull: 17 cull:92)
	>>> 5
	"
	"(#closeTo:precision: cull: 3 cull: 2 cull: 17 cull:92)
	>>> false
	"
	^ self numArgs < 3
		ifTrue: [self cull: firstArg cull: secondArg cull: thirdArg]
		ifFalse: [self value: firstArg value: secondArg value: thirdArg value: fourthArg]
]

{ #category : #'*PharoFunctional' }
Symbol >> curry: anObject [
	^ [: left |  left perform: self with: anObject ]
]

{ #category : #'*PharoFunctional' }
Symbol >> map: aCollection [
	"#negated map: #(1 2 3)
	>>> #(-1 -2 -3)
	"
	^ aCollection collect: self
]

{ #category : #'*PharoFunctional' }
Symbol >> map: aCollection map: anotherCollection [
	"#+ map: #(1 2 3) map: #(-1 0 1)
	>>> #(0 2 4)
	"
	^ aCollection with: anotherCollection collect: self
]

{ #category : #'*PharoFunctional' }
Symbol >> value: firstArg value: secondArg [
	"(#+ value: 3 value: 2)
	>>> 5
	"
	^ firstArg perform: self with: secondArg
]

{ #category : #'*PharoFunctional' }
Symbol >> value: firstArg value: secondArg value: thirdArg [
	^ firstArg perform: self with: secondArg with: thirdArg
]

{ #category : #'*PharoFunctional' }
Symbol >> value: firstArg value: secondArg value: thirdArg value: fourthArg [
	^ firstArg perform: self with: secondArg with: thirdArg with: fourthArg
]

{ #category : #'*PharoFunctional' }
Symbol >> valueWithArguments: anArray [
	anArray size = 2 ifTrue: [ ^ anArray first perform: self with: anArray last ].
	^ anArray first perform: self withArguments: anArray allButFirst
]

{ #category : #'*PharoFunctional' }
Symbol >> |> aBlock [
   "This is the B combinator also known as the Bluebird"
   (self numArgsAsBlock = 1 and:
       aBlock numArgsAsBlock = 1) ifFalse: [ 
      ^ ArityError signal ].
   ^ [ :x | aBlock value: (self value: x) ]
]
