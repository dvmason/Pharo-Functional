Extension { #name : #Interval }

{ #category : #'*Pharo-Functional' }
Interval >> reversed [
	^ self class from: stop to: start by: step negated
]
