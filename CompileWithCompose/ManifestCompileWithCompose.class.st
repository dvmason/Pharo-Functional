"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCompileWithCompose,
	#superclass : #PackageManifest,
	#category : #'CompileWithCompose-Manifest'
}

{ #category : #'code-critics' }
ManifestCompileWithCompose class >> ruleLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#ComposeParser #parseArray #false)) #'2022-08-04T16:17:30.361051-04:00') )
]

{ #category : #'code-critics' }
ManifestCompileWithCompose class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#ComposeParser)) #'2021-01-29T08:31:07.092731-05:00') )
]

{ #category : #'code-critics' }
ManifestCompileWithCompose class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#ComposeParser #parseArray #false)) #'2022-08-04T17:10:33.07669-04:00') )
]
