Extension { #name : #String }

{ #category : #'*PharoFunctional' }
String >> splitOnAny: aString [ 
	^ [ :e | aString includes: e ] split: self.
]
