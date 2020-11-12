"
I subclass the RBScanner and add syntax recognition for a compose syntax: ':>'
"
Class {
	#name : #ComposeScanner,
	#superclass : #RBScanner,
	#category : #'Pharo-Functional-Compose'
}

{ #category : #'private-scanning' }
ComposeScanner >> scanIdentifierOrKeyword [
	| name |
	self scanName.
	(currentCharacter = $: and: [stream peek ~= $= and: [stream peek ~= $>]]) 
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

{ #category : #'private-scanning' }
ComposeScanner >> scanSpecialCharacter [
	currentCharacter = $: 
		ifTrue: [
			self step.
			^ currentCharacter = $= 
				ifTrue: [
					self step.
					RBAssignmentToken start: tokenStart]
				ifFalse: [currentCharacter = $>
					ifTrue: [
						self step.
						ComposePipeToken start: tokenStart]
					ifFalse: [ RBSpecialCharacterToken value: $: start: tokenStart ]]].

	^ super scanSpecialCharacter
]
