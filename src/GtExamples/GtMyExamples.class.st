Class {
	#name : #GtMyExamples,
	#superclass : #Object,
	#category : #'GtExamples-Core'
}

{ #category : #accessing }
GtMyExamples >> run [
	| root width height stepX stepY|
	root := BlElement new.
	width := 800.
	height := 400.
	stepX := 10.
	stepY := 10.
	root size: width @ height.
	1 to: height by: stepY do: [:gridY | 
		1 to: width by: stepX do: [:gridX | |child| 
			child := BlElement new.
			child relocate: gridX @ gridY.
			child size: stepX @ stepY+1.
			child background: (Color h: gridX s: height - gridY v: 100).
			root addChild: child
			]].
	^ root
]
