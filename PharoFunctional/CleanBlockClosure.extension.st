Extension { #name : #CleanBlockClosure }

{ #category : #'*PharoFunctional' }
CleanBlockClosure >> curry [

	CleanBlockClosureCurryable adoptInstance: self.
	^ self
]
