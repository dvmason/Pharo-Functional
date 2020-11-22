Class {
	#name : #BaselineOfPharoFunctional,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoFunctional
}

{ #category : #baselines }
BaselineOfPharoFunctional >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
		"Packages"
			spec
				package: 'Pharo-Functional';
				package: 'Pharo-Functional-Tests'  with: [ spec requires: #('Pharo-Functional') ];
				package: 'CompileWithCompose';
				package: 'CompileWithCompose-Tests'  with: [ spec requires: #('CompileWithCompose') ].
		"Groups"
			spec
				group: 'default' with: #('Pharo-Functional' CompileWithCompose);
				group: 'functional' with: #('Pharo-Functional');
				group: 'compiler' with: #(CompileWithCompose);
				group: 'All' with: #('Pharo-Functional' 'Pharo-Functional-Tests' 'CompileWithCompose' 'CompileWithCompose-Tests')
		]
]
