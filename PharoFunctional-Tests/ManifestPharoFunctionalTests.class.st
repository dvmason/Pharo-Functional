"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoFunctionalTests,
	#superclass : #PackageManifest,
	#category : #'PharoFunctional-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoFunctionalTests class >> ruleExtraBlockRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'PharoFunctional-Tests')) #'2020-11-22T12:02:47.703658-05:00') )
]

{ #category : #'code-critics' }
ManifestPharoFunctionalTests class >> ruleLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#TupleTest)) #'2020-10-21T23:34:04.860994-04:00') )
]
