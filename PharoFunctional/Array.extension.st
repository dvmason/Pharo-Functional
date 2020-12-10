Extension { #name : #Array }

{ #category : #'*PharoFunctional' }
Array >> adjacentDifference [ 
	^ self slide: 2
	    :> reversed
	    :> collect: [ :e | e fold: #- ].
]
