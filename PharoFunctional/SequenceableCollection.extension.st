Extension { #name : #SequenceableCollection }

{ #category : #'*PharoFunctional' }
SequenceableCollection >> >==< other [
	^ ZippedCollection new with: self with: other
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> adjacentDifference [ 
	^ ((self slide: 2
	    ) reversed
	    ) collect: [ :e | e fold: #- ].
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> adjacentFind: binaryBlock [
	^ self zipFind: (self allButFirst) with: binaryBlock.
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> combinationsOf: anInteger [ 
	^ self combinationsOf: anInteger select: [: ignore | true ] collect: #yourself
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> combinationsOf: anInteger collect: valueBlock [ 
	^ self combinationsOf: anInteger select: [: ignore | true] collect: valueBlock
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> combinationsOf: anInteger select: aFullBlockClosure [ 
	^ self combinationsOf: anInteger select: aFullBlockClosure collect: #yourself
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> combinationsOf: anInteger select: testBlock collect: valueBlock [
	^ Array
		streamContents: [ :stream | 
			self combinations: anInteger atATimeDo: [ :combination |
				(testBlock value: combination) ifTrue: [ stream nextPut: (valueBlock value: combination copy) ] ] ]
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> copyReplace: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	Collect the resulting values into a copy of self."
	"('ab cd ab ef ab' copyReplace: [: c | c=$a ifTrue: $z ifFalse: c]) >>> 'zb cd zb ef zb'"
	^ self species new: self size streamContents: [ :stream |
			self do: [ :anObject |
				stream nextPut: (aBlock value: anObject) ]]
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> cycle: anInteger [ 
   | temp |
   temp := (self class) new: anInteger.
   1 to: anInteger do: [ :i |
      temp at: i put: (self at: i - 1 \\ (self size) + 1)
   ].
   ^ temp
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> destructure: aBlock [
	^ aBlock valueWithArguments: self
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> groupByRuns2Arg: aBlock [
	"Answer a new collection of the same species as the receiver with elements being collections (of the receiver species) containing those elements of the receiver for which the given block applied to 2 consecutive values evaluates to true."

	"(#(1 2 3 4 4 1 1) groupByRuns2Arg: [ :l :r | l = r]) >>> #((1) (2) (3) (4 4) (1 1))"

	"(#(1 2 3 4 1 2 3 3 4 5 1 ) groupByRuns2Arg: #<=) >>> #((1 2 3 4) (1 2 3 3 4 5) (1))"

	| str eStr compare prev |
	str := Array new writeStream.
	prev := nil.
	compare := false.
	eStr := self species new writeStream.
	self do: [ :e |
			(compare and: [ aBlock value: prev value: e ]) ifFalse: [
					eStr isEmpty ifFalse: [
						str nextPut: (eStr contents as: self species).
						eStr reset ] ].
			eStr nextPut: e.
			compare := true.
			prev := e.
	].
	eStr isEmpty ifFalse: [ str nextPut: (eStr contents as: self species) ].
	^ str contents
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> isUnique [
	^ self unique size = self size.
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> slide: width [
   | start end result |
   start   := 1.
   end   := width.
   result := self species ofSize: self size - width +1.
   [ end > self size ] whileFalse: [
	   result at: start put: (self copyFrom: start to: end).
	   start := start + 1.
	   end := end + 1.
	].
   ^ result   
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> unique [
   "unique is stable in that it keeps the order that unique elments occur"
   | uniq size |
   uniq := Set new.
   size := 0.
   ^ self select: [ :e | (uniq add: e;size)> size and: [size := size + 1. true]]
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> zip: aCollection [ 
	^ ZippedCollection new with: self with: aCollection
]

{ #category : #'*PharoFunctional' }
SequenceableCollection >> zipFind: aCollection with: binaryBlock [
   " currently doesn't work if zipFind doesn't find a match"
   ^ ((self zip: aCollection
       ) select: [ :first : second | binaryBlock value: first value: second]
       ) emptyOrNilOr: #first.
]
