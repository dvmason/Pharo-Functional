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
				package: 'PharoFunctional';
				package: 'PharoFunctional-Tests'  with: [ spec requires: #('PharoFunctional') ];
				package: 'CompileWithCompose';
				package: 'CompileWithCompose-Tests'  with: [ spec requires: #('CompileWithCompose') ].
		"Groups"
			spec
				group: 'default' with: #('PharoFunctional' CompileWithCompose);
				group: 'functional' with: #('PharoFunctional');
				group: 'compiler' with: #(CompileWithCompose);
				group: 'All' with: #('PharoFunctional' 'PharoFunctional-Tests' 'CompileWithCompose' 'CompileWithCompose-Tests')
		]
]
