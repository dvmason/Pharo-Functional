# CompileWithCompose
This adds a compose or pipe syntax to Pharo. It can significantly
reduce the need for parentheses and make functional code more readable.

For example:
```smalltalk
foo
	" self new foo >>> 42 "
	^ 17 negated
		:> min: -53
		:> abs
		:> < 100
		:> and: [ 4 > 2 ]
		:> and: [ 5 < 10 ]
		:> ifTrue: [ 42 ] ifFalse: [ 99 ]
        ```
The precedence is between cascade and assigment, so you could say
something like:
```smalltalk
x := OrderedCollection new
			add: 42;
			add: 17;
			yourself
        :> collect: #negated
        :> add: 35;
        	add: 99
        :> with: #(1 2 3 4) collect: [:l :r| l+r ]
        :> max
```
# Pharo-Functional
Functional support for Pharo

This project is to add to Smalltalk additional data structures and methods that are familiar to functional programmers
