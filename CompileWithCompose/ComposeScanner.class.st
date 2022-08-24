"
I subclass the RBScanner and add syntax recognition for a compose syntax: ':>'
"
Class {
	#name : #ComposeScanner,
	#superclass : #RBScanner,
	#category : #'CompileWithCompose-Kernel'
}

{ #category : #'private - scanning' }
ComposeScanner >> scanIdentifierOrKeyword [
	"!! Attention !! There are 3 case of Literal Tokens : true, false and nil."
	"This scan accepts keywords only containing a colon."
	"The presence of a colon will mark the creation of a keyword, except when followed with a specialCharacter.
	 Otherwise an Identifier is created."
	"To ensure the pertinence of this scanner, it must be called only if the current character is 	, 	 	 alphabetic."
	| name |
	self scanName.
	(currentCharacter = $: and: [ (Character specialCharacters includes: stream peek) not ]) 
		ifTrue: [^self scanKeyword].
	name := buffer contents.
	name = 'true' 
		ifTrue: 
			[^RBLiteralToken 
				value: true
				start: tokenStart
				stop: self previousStepPosition].
	name = 'false' 
		ifTrue: 
			[^RBLiteralToken 
				value: false
				start: tokenStart
				stop: self previousStepPosition].
	name = 'nil' 
		ifTrue: 
			[^RBLiteralToken 
				value: nil
				start: tokenStart
				stop: self previousStepPosition].
	^RBIdentifierToken value: name start: tokenStart
]

{ #category : #'private - scanning' }
ComposeScanner >> scanSpecialCharacter [

	currentCharacter = $: ifTrue: [ 
		self step.
		^ currentCharacter = $=
			  ifTrue: [ 
				  self step.
				  RBAssignmentToken start: tokenStart ]
			  ifFalse: [ 
				  currentCharacter = $>
					  ifTrue: [ 
						  self step.
						  ComposePipeToken start: tokenStart ]
					  ifFalse: [ 
						  currentCharacter = $|
							  ifTrue: [ 
								  self step.
								  ComposeColonBarToken start: tokenStart ]
							  ifFalse: [ 
							  RBSpecialCharacterToken value: $: start: tokenStart ] ] ] ].

	^ super scanSpecialCharacter
]
