"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoFunctionalTests,
	#superclass : #PackageManifest,
	#category : #'Pharo-Functional-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoFunctionalTests class >> ruleLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#TupleTest)) #'2020-10-21T23:34:04.860994-04:00') )
]
