Class {
	#name : #BaselineOfGtExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtExamples
}

{ #category : #loading }
BaselineOfGtExamples class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'gt-examples' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfGtExamples >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GtExamples'
		]
]
