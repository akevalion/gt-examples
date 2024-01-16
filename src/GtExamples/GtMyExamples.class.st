Class {
	#name : #GtMyExamples,
	#superclass : #Object,
	#category : #'GtExamples-Core'
}

{ #category : #accessing }
GtMyExamples >> run [
	<gtExample>
	| root width height stepX stepY scaleH scaleS |
	root := BlSpartaElement new.
	width := 800.
	height := 400.
	stepX := 10.
	stepY := 10.
	root size: width @ height.
	scaleH := NSScale linear
		domain: {0. width};
		range: {0. 360}.
	scaleS := NSScale linear
		domain: {0. height}.
	root rendering: [:aCanvas :element |
		1 to: height by: stepY do: [:gridY | 
			1 to: width by: stepX do: [:gridX | 
				aCanvas fill
					paint: (Color 
						h: (scaleH scale: gridX)
						s: (scaleS scale: (height - gridY))
						v: 1);
					path: (gridX @ gridY extent: stepX @ stepY)  ;
					draw
			]
		].
		
	].
	root 
		when: BlMouseMoveEvent
		do: [:evt |
			stepX := evt parentPosition x + 10.
			stepY := evt parentPosition y + 10.
			root invalidate
		].
	
	^ root
]

{ #category : #accessing }
GtMyExamples >> runWheel [
	<gtExample>
	| wheel segmentCount |
	wheel := BlElement new.
	segmentCount := 1.
	^ wheel
]
