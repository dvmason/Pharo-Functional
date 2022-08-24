# CompileWithCompose
This is an alternate compiler built on top of Pharo's Opal compiler. It can be the compiler of choice for any class. All of the syntax proposed here is otherwise syntax errors that can be recognized by this compiler and turned into legal Pharo Smalltalk. However, the source would still contain these syntax elements... only the internal AST is affected. Only if you lost your source code and recovered it from reverse-compilation would you lose the syntactic forms.

## Already implemented syntax extensions

### Compose / pipe / parrot operator
This adds a compose or pipe syntax to Pharo (we call it the parrot operator `:>`). It can significantly reduce the need for parentheses and make functional code more readable. It works with PharoJS and can be very convenient when using some Javascript
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

### Expressions as unary or binary messages
A proposed extension adds a syntax to support composing blocks or symbols with combinators. This can be very convenient when used with the parrot operator, as well as `curry:` and some other messages from the Pharo-Functional part of this repository. This reduces the amount of visual noise from `value:` and `value:value:` messages. Anywhere a unary messsage can go, you can instead put an expression in parentheses or put a block. Anywhere a binary message can go, you can do the same, but follow the close-parenthesis with a colon (`:`). This is extremely useful with the combinators described later.

For example:
```smalltalk
x (...)
([...] value: x)

x (...) + y
([...] value: x) + y

x (...): y
([...] value: x value: y)

x (#sort <|> #=)
```

You can do the same with unary or binary blocks. Because we know the arity of blocks the trailing `:` isn't used for block operators
```smalltalk
x [:w|...]
([:w|...] value: x)

x [:w:z|...] y
([:w:z|...] value: x value: y)
```

If you had a unary or binary block in a variable, you could use it with the parenthesis syntax:
```smalltalk
a: aBlock
   ^ 42 (aBlock): 17
```

### Initializing local variables at point of declaration
Initializing variables at the point of declaration is best-practise in most of the programming world. Note that if a `:=` or `=` appears in a declaration, the expression must be terminated with a `.` and it can't be omitted on the last initialization:
```smalltalk
| x := 42. y = x+5. z|
```
is legal, but
```smalltalk
| x := 42. y = x+5. z = 17 |
```
is illegal, because the trailing `|` would be be ambigous.
Note that `:=` declares and initializes a mutable variable and `=` declares and initializes an immutable variable.

### Collection literals
Arrays have a literal syntax `{1 . 2 . 3}`, but other collections don't. This extension would recognize `:className` immediately after the `{` and if the className were a collection it would translate, e.g. 
```smalltalk
{:Set 3 . 4 . 5 . 3}
{:Dictionary #a->1 . #b->2}
```
to 
```smalltalk
Set with: 3 with: 4 with: 5 with: 3
Dictionary with: #a->1 with: #b->2
```
If there are more than 6 values, it will use `withAll:` and an array.

### Destructuring collections
There isn't a convenient way to return multiple values from a method, or even to extract multiple values from a collection. We propose:
```smalltalk
:| a b c | := some-collection
```
which would destructure the 3 elements of a SequenceableCollection or would extract the value of keys `#a` `#b` etc. if it was a Dictionary, with anything else being a runtime error. This is conveniently done by converting that to:
```smalltalk
([:temp|
	a := temp firstNamed: #a.
	b := temp secondNamed: #b.
	c := temp thirdNames: #c] value: some-collection)
```
These `firstNamed:`, etc. methods would be trivial to implement in those collection classes and also other classes could handle them if appropriate. A nice estension might be for this syntax to also define those local variables in the nearest enclosing scope if they aren't already accessible.

## Proposed syntax extensions
While these might be convenient, they really would need a more generalized syntax, and even this simple version is hard to compile.
### Currying (partial expressions)
`curry:` is very convenient to partially apply parameters to a binary operator. And of course the binary operator could be any of the above operators:
```smalltalk
x := (3+).
y := (*4).
```
would become:
```smalltalk
x := [:temp| 3+temp].
y := [:temp| temp*4].
```

These are very convenient to use with the parrot operator:
```smalltalk
x :> + 3 :> (...): 7 :> [...] y :> (4-) :> - 4
```

## How to use this
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
	" Answer a compiler class appropriate for source methods of this class and subclasses. "
	^ ComposeCompiler
```
You can use this second approach if you want to add it to the entire image (including in playgrounds), by defining this in Object class.

# Pharo-Functional
Functional support for Pharo

This project is to add to Smalltalk additional data structures and methods that are familiar to functional programmers

## Tuple class
It includes Tuple class, which is a read-only Array.

## Extended Symbols support
It makes Symbols work as unary, binary, ternary, or quatrenary operators

It adds a unary and binary `map:` and `map:map:` to symbols, so:
 + `#negated map: #(1 2 3)` equals ``#(-1 -2 -3)`
 + `#+ map: #(1 2 3) map: #(-1 0 1)` equals ``#(0 2 4)`

## ZippedCollection
It also includes ZippedCollection which is a collection of Pairs.
`collect:` and `do:` on ZippedCollection will call the block/symbol with either a Pair (if it's 1-argument) or the pair of elements from the two collections (if it's 2-argument)
SequenceableCollections can be zipped together with either `zip:` or `>==<

## `curry:` method
It also includes a `curry:` method that allows composing a value and a binary operator or block, so:
 + `(5 curry: [:l :r | l-r]) value: 4` equals `1`
 + `([:l :r | l-r] curry: 4) value: 9` equals `5`
 + `(5 curry: #-) value: 4` equals `1`
 + `(#- curry: 4) value: 9` equals `5`
(where the latter 2 depend on Symbols working as binary operators)

If programming in a class with `CompileWithCompose` enabled, you can use this as, for example:
+ `4 (5 curry: #-)` equals `1`
+ `x := #- curry: 4. 9 (x)` equals `5`
+ `addArrays := #+ curry: #map:map:. #(1 2 3) (addArrays): #(-1 0 1)` equals `#(0 2 4)` - note the `(...):` because the curried function requires 2 values - i.e. it's a binary message.

## slices
Slices allow a view on a data structure that can be iterated over. This is an extension of slices as seen in Rust and Zig. This works well for iterators while minimizing the copying of data.
```smalltalk
 #(1 2 3 4 5 6 7 8) sliceFrom: 3 to: 7
      :> reduceWith: #(true false true true false)
	  :> collect: #negated
 ```
 would give `#(-3 -5 -6)` without creating any garbage (i.e. the collect is the first place that allocates some memory.
## chain method
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
