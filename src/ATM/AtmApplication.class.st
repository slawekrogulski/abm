Class {
	#name : 'AtmApplication',
	#superclass : 'SpApplication',
	#instVars : [
		'loggedInUser'
	],
	#classInstVars : [
		'presenters'
	],
	#category : 'ATM',
	#package : 'ATM'
}

{ #category : 'adding' }
AtmApplication class >> addPresenterToUpdate: aPresenter for: loggedInUser [
	Transcript show: ('addPresenterToUpdate for: {1}' format: {loggedInUser }); cr.
	presenters at: loggedInUser put: aPresenter .
	
]

{ #category : 'class initialization' }
AtmApplication class >> initialize [ 
	presenters := Dictionary new.
]

{ #category : 'as yet unclassified' }
AtmApplication class >> registeredPresenters [ 
	presenters keysAndValuesDo: [ 
		:key :presenter |
		Transcript show: ('registered presenter for {1}' format: {key}); cr.  ]
]

{ #category : 'adding' }
AtmApplication class >> removePresenterToUpdateFor: loggedInUser [
	|message|
	message := 'removePresenterToUpdateFor for: {1} - ' format: {loggedInUser }.
	(presenters removeKey: loggedInUser ifAbsent: [ nil ])
		ifNotNil: [ message := message , 'Done']  
		ifNil: [message :=  message , 'Ignored'].
	message traceCr .
	
]

{ #category : 'as yet unclassified' }
AtmApplication class >> updatePresenters [ 
	presenters keysAndValuesDo: [ 
		:key :presenter |
		Transcript show: ('UpdatePresenter {1}' format: {key}); cr. 
		presenter updatePresenter ]
]

{ #category : 'initialization' }
AtmApplication >> initialize [ 
	super initialize .
	"self styleSheet inspect."
]

{ #category : 'accessing' }
AtmApplication >> loggedInUser [

	^ loggedInUser
]

{ #category : 'accessing' }
AtmApplication >> loggedInUser: anObject [

	loggedInUser := anObject
]

{ #category : 'running' }
AtmApplication >> run [ 
	super run.
]

{ #category : 'running' }
AtmApplication >> start [
	|presenter|
	"^ ( self new: AtmMainPresenter  ) open".
	presenter := self new: LoginPresenter.
	"self class addPresenterToUpdate: presenter."
	presenter open.
]

{ #category : 'accessing' }
AtmApplication >> startMain [
	|presenter|
	"^ ( self new: AtmMainPresenter  ) open".
	presenter := self new: AtmFormPresenter.
	self class addPresenterToUpdate: presenter for: self loggedInUser .
	presenter open.

]

{ #category : 'styling' }
AtmApplication >> styleSheet [ 
	|style|
	style := (SpStyleVariableSTONReader fromString:
		'.application [
			.toolbarText [Font { #size: 12 }],
			.balanceLabel [ Font { #size: 20 } ],
			.toolbarButtonLabelStyle [ Font { #size: 22 } ]
		]').
	^ super styleSheet , style
]
