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
					path: (gridX @ gridY extent: stepX @ stepY + 1)  ;
					draw
			]
		].
		
	].
	root 
		when: BlMouseMoveEvent
		do: [:evt |
			stepX := evt parentPosition x + 4.
			stepY := evt parentPosition y + 4.
			root invalidate
		].
	
	^ root
]

{ #category : #accessing }
GtMyExamples >> runWheel [
	<gtExample>
	| wheel segmentCount mousePosition radius center width height
	oldVertex scaleS scaleV |
	wheel := BlSpartaElement new.
	width := height := 500.
	wheel size: width @ height.
	scaleS := NSScale linear domain: {0. width}.
	scaleV := NSScale linear domain: {0. height}.
	
	center := width @ height / 2.
	mousePosition := width @ height.
	segmentCount := 6.
	radius := 250.
	wheel rendering: [:canvas :element |
		oldVertex := nil.
		(0 to: 360 by: 360/segmentCount) do:[:angle |
			| color rad vertex |
			rad := angle degreesToRadians.
			vertex := rad sin @ rad cos * radius + center.
			oldVertex ifNil: [ oldVertex := vertex ]
			ifNotNil: [ | path |
				
				color := Color 
					h: angle
					s: (scaleS scale: mousePosition x)
					v: (scaleV scale: mousePosition y).
				path := canvas path
					absolute;
					moveTo: center;
					lineTo: oldVertex;
					lineTo: vertex;
					close;
					build.
				oldVertex := vertex.
				canvas fill
					paint: color;
					path: path;
					draw.
			].
		].
	].
	wheel 
		when: BlMouseMoveEvent
		do: [:evt |
			mousePosition := evt parentPosition.
			wheel invalidate
		];
		beFocusable;
		when: BlKeyDownEvent
		do: [ :evt | 
			evt key name = '1' ifTrue: [segmentCount := 360 ].
			evt key name = '2' ifTrue: [segmentCount := 45 ].
			evt key name = '3' ifTrue: [segmentCount := 24 ].
			evt key name = '4' ifTrue: [segmentCount := 12 ].
			evt key name = '5' ifTrue: [segmentCount := 6 ].
			wheel invalidate.];
		requestFocus.
	^ wheel
]
