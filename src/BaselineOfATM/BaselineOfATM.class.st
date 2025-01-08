Class {
	#name : 'BaselineOfATM',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfATM',
	#package : 'BaselineOfATM'
}

{ #category : 'baselines' }
BaselineOfATM >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec preLoadDoIt: #'preload:package:'.
			spec postLoadDoIt: #'postload:package:'.
			spec package: 'ATM'. ]
]

{ #category : 'actions' }
BaselineOfATM >> postload: loader package: packageSpec [

	Transcript crShow: 'ATM::Project loaded!'
]

{ #category : 'actions' }
BaselineOfATM >> preload: loader package: packageSpec [

	Transcript crShow: 'ATM::The fetch was finished. Now let''s load the project'
]

{ #category : 'accessing' }
BaselineOfATM >> projectClass [
	^ MetacelloCypressBaselineProject
]
