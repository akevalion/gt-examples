Class {
	#name : #GtMyExamples,
	#superclass : #Object,
	#category : #'GtExamples-Core'
}

{ #category : #accessing }
GtMyExamples >> run [
	<gtExample>
	| root width height stepX stepY scale |
	root := BlElement new.
	width := 800.
	height := 400.
	stepX := 10.
	stepY := 10.
	root size: width @ height.
	scale := NSScale linear
		domain: {0. width};
		range: {0. 360}.
	1 to: height by: stepY do: [:gridY | 
		1 to: width by: stepX do: [:gridX | |child| 
			child := BlElement new.
			child relocate: gridX @ gridY.
			child size: stepX @ stepY+1.
			
			child background: (Color 
				h: (scale scale: gridX)
				s: (height - gridY)/height
				v: 1).
			root addChild: child
			]].
	^ root
]
