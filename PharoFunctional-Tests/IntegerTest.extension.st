Extension { #name : #IntegerTest }

{ #category : #'*PharoFunctional-Tests' }
IntegerTest >> testIota [
	self assert: 5 iota asArray equals: #(1 2 3 4 5).
	self assert: 0 iota asArray equals: #().

]

{ #category : #'*PharoFunctional-Tests' }
IntegerTest >> testIotaBlock [
	self assert: (5 iota: [: i | i+3 ]) equals: #(4 5 6 7 8).
	self assert: (0 iota: [: i | i+3 ]) equals: #().

]
