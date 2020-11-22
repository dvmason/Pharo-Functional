Extension { #name : #Interval }

{ #category : #'*PharoFunctional' }
Interval >> reversed [
	^ self class from: stop to: start by: step negated
]
