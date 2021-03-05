# CompileWithCompose
This adds a compose or pipe syntax to Pharo. It can significantly
reduce the need for parentheses and make functional code more readable.
It works with PharoJS and can be very convenient when using some Javascript
libraries such as D3.

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
The precedence is the same as cascade, so you can intermix them and could say
something like:
```smalltalk
x := OrderedCollection new
			add: 42;
			add: 17;
			yourself
        :> collect: #negated
        :> add: 35;
        	add: 99;
		yourself
        :> with: #(1 2 3 4) collect: [:l :r| l+r ]
        :> max
```
You can load into a Pharo image Playground with:
```smalltalk
Metacello new 
    baseline: 'PharoFunctional';
    repository: 'github://dvmason/Pharo-Functional:master';
    load: #compiler
```
Then for any class heirarchy where you want to use the extended syntax, add a trait to the class (the uses: line), like:
```smalltalk
RBScannerTest subclass: #ComposeExampleTest
	uses: ComposeSyntax
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'CompileWithCompose-Tests'
```
Or, on the class-side define the following method:
```smalltalk
compilerClass
	"Answer a compiler class appropriate for source methods of a class that uses this trait."
	^ ComposeCompiler
```
You can use this second approach if you want to add it to the entire image (including in playgrounds), by defining this in Object class.
# Pharo-Functional
Functional support for Pharo

This project is to add to Smalltalk additional data structures and methods that are familiar to functional programmers

It includes Tuple class, which is a read-only Array.

It makes Symbols work as unary, binary, ternary, or quatrenary operators

It adds a unary and binary `map:` and `map:map:` to symbols, so:
 + `#negated map: #(1 2 3)` equals #(-1 -2 -3)
 + `#+ map: #(1 2 3) map: #(-1 0 1)` equals #(0 2 4)

It also includes ZippedCollection which is a collection of Pairs.
`collect:` and `do:` on ZippedCollection will call the block/symbol with either a Pair (if it's 1-argument) or the pair of elements from the two collections (if it's 2-argument)
SequenceableCollections can be zipped together with either `zip:` or `>==<

It also includes a `curry:` method that allows composing a value and a binary operator or block, so:
 + `(5 curry: [:l :r | l-r]) value: 4` equals 1
 + `([:l :r | l-r] curry: 4) value: 9` equals 5
 + `(5 curry: #-) value: 4` equals `1`
 + `(#- curry: 4) value: 9` equals 5
(where the latter 2 depend on 

It also includes a chain method that allows similar code to `CompileWithCompose` but with no additional syntax (unfortunately quite a bit slower because it requires a DNU and `perform` for each chained message:
```smalltalk
foo
	" self new foo >>> 42 "
	^ 17 chain 
	        negated
		; min: -53
		; abs
		; < 100
		; and: [ 4 > 2 ]
		; and: [ 5 < 10 ]
		; ifTrue: [ 42 ] ifFalse: [ 99 ]
```

# Loading
To load, in a Pharo9 image Playground do:
```smalltalk
Metacello new
	repository: 'github://dvmason/Pharo-Functional:master';
	baseline: 'PharoFunctional';
	load
```
