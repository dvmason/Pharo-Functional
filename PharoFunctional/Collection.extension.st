Extension { #name : #Collection }

{ #category : #'*PharoFunctional' }
Collection >> at: anObject ifAbsent: anotherObject [
" Not all subclasses of Collection implement this,
  but Dictionary, OrderedDictionary, and SequenceableCollection all do,
  so this seems like the right place "
	^ self subclassResponsibility
]

{ #category : #'*PharoFunctional' }
Collection >> emptyOrNilOr: aBlock [
	self isEmpty ifTrue: [ ^ nil ].
	^ aBlock value: self
]

{ #category : #'*PharoFunctional' }
Collection >> frequencies [
	^ self asBag valuesAndCounts.
]

{ #category : #'*PharoFunctional' }
Collection >> product [
   ^ self inject: 1 into: #*
]

{ #category : #'*PharoFunctional' }
Collection >> rotate: anInteger [ 
   ^ (self last: self size - anInteger), (self first: anInteger)
]

{ #category : #'*PharoFunctional' }
Collection >> scan: aBlock [
	| accumulator first |
	first := true.
	^ self collect: [:each |
		first ifTrue: [
			first := false. accumulator := each
		] ifFalse: [
			accumulator := aBlock value: accumulator value: each
		]]
]

{ #category : #'*PharoFunctional' }
Collection >> value: anObject [
	^ self at: anObject ifAbsent: anObject
]
