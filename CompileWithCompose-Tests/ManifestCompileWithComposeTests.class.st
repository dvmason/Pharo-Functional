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
