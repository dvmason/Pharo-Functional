Extension { #name : #Object }

{ #category : #'*Pharo-Functional' }
Object >> curry: aBlock [
	^ [: right |  aBlock value: self value: right]
]
