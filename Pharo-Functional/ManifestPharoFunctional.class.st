"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoFunctional,
	#superclass : #PackageManifest,
	#category : #'Pharo-Functional-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoFunctional class >> ruleModifiesCollectionRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SequenceableCollection #groupByRuns2Arg: #false)) #'2020-11-04T18:04:28.635305-05:00') )
]

{ #category : #'code-critics' }
ManifestPharoFunctional class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Symbol #/ #false)) #'2020-02-20T23:25:56.72196-05:00') #(#(#RGMethodDefinition #(#Symbol #valueWithArguments: #false)) #'2020-02-21T19:12:39.662584-05:00') #(#(#RGMethodDefinition #(#Symbol #value:value: #false)) #'2020-02-21T19:28:42.318368-05:00') )
]

{ #category : #'code-critics' }
ManifestPharoFunctional class >> ruleRBToDoCollectRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Integer #iota: #false)) #'2020-03-09T08:09:54.106096-04:00') )
]
