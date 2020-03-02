Extension { #name : #Symbol }

{ #category : #'*Pharo-Functional' }
Symbol >> argumentCount [
	^ self numArgs + 1
]

{ #category : #'*Pharo-Functional' }
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

{ #category : #'*Pharo-Functional' }
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

{ #category : #'*Pharo-Functional' }
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

{ #category : #'*Pharo-Functional' }
Symbol >> value: firstArg value: secondArg [
	"(#+ value: 3 value: 2)
	>>> 5
	"
	^ firstArg perform: self with: secondArg
]

{ #category : #'*Pharo-Functional' }
Symbol >> value: firstArg value: secondArg value: thirdArg [
	^ firstArg perform: self with: secondArg with: thirdArg
]

{ #category : #'*Pharo-Functional' }
Symbol >> value: firstArg value: secondArg value: thirdArg value: fourthArg [
	^ firstArg perform: self with: secondArg with: thirdArg with: fourthArg
]

{ #category : #'*Pharo-Functional' }
Symbol >> valueWithArguments: arguments [
	arguments size = 2 ifTrue: [ ^ arguments first perform: self with: arguments last ].
	^ arguments first perform: self withArguments: arguments allButFirst
]