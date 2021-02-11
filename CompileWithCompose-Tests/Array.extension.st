Extension { #name : #Array }

{ #category : #'*CompileWithCompose-Tests' }
Array >> asComposeExample [
	^ ComposeExample new first: self first;second: self second;yourself
]
