"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoFunctionalTests,
	#superclass : #PackageManifest,
	#category : #'PharoFunctional-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoFunctionalTests class >> ruleAssertEqualSignIntoAssertEqualsV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#FunctionalTest #testCombinatorOver #false)) #'2022-08-19T16:06:26.915828-04:00') )
]

{ #category : #'code-critics' }
ManifestPharoFunctionalTests class >> ruleExtraBlockRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'PharoFunctional-Tests')) #'2020-11-22T12:02:47.703658-05:00') )
]

{ #category : #'code-critics' }
ManifestPharoFunctionalTests class >> ruleLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#TupleTest)) #'2020-10-21T23:34:04.860994-04:00') )
]

{ #category : #'code-critics' }
ManifestPharoFunctionalTests class >> ruleSearchingLiteralRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#FunctionalTest #testCombinatorOverWithGroupByRuns2Arg #false)) #'2022-08-23T14:18:52.916185+02:00') )
]
