Extension { #name : #Array }

{ #category : #'*PharoFunctional' }
Array >> adjacentDifference [ 
	^ ((self slide: 2
	    ) reversed
	    ) collect: [ :e | e fold: #- ].
]

{ #category : #'*PharoFunctional' }
Array >> unique [
   "unique is stable in that it keeps the order that unique elments occur"
   | uniq temp |
   temp := OrderedCollection new.
   uniq := Set new.
   self do: [ :e | (uniq includes: e) ifFalse: [ uniq add: e. temp add: e ] ].
   ^ temp asArray
]
