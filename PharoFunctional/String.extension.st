Extension { #name : #String }

{ #category : #'*PharoFunctional' }
String >> numArgsAsBlock [
   ^ self numArgs + 1
]

{ #category : #'*PharoFunctional' }
String >> splitOnAny: aString [ 
	^ [ :e | aString includes: e ] split: self.
]
