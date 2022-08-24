"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCompileWithComposeTests,
	#superclass : #PackageManifest,
	#category : #'CompileWithCompose-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestCompileWithComposeTests class >> ruleExtraBlockRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'CompileWithCompose-Tests')) #'2022-08-04T23:21:39.540736-04:00') )
]

{ #category : #'code-critics' }
ManifestCompileWithComposeTests class >> ruleLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#ComposeExampleTest #testDestructure #false)) #'2022-08-24T06:11:29.499051+02:00') )
]

{ #category : #'code-critics' }
ManifestCompileWithComposeTests class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#ComposeExampleTest #testAssignDeclarations #false)) #'2022-08-24T05:20:07.12452+02:00') #(#(#RGMethodDefinition #(#ComposeExampleTest #testDestructure #false)) #'2022-08-24T06:11:34.470254+02:00') )
]
