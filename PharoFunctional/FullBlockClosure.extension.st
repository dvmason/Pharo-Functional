Extension { #name : #FullBlockClosure }

{ #category : #'*PharoFunctional' }
FullBlockClosure >> curry [

	FullBlockClosureCurryable adoptInstance: self.
	^ self
]
