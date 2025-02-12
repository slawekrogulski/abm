"
Add user dialogue
"
Class {
	#name : 'UserAddPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'userNameInput'
	],
	#category : 'ATM-ui',
	#package : 'ATM',
	#tag : 'ui'
}

{ #category : 'layout' }
UserAddPresenter >> defaultLayout [ 
	|grid |
	grid := SpGridLayout build: [ :builder |
		builder
			column: 2 expand: false; 
			add: 'Name'; add: userNameInput ].
	^SpBoxLayout newTopToBottom 
		add: grid;
		yourself. 
	
]

{ #category : 'initialization' }
UserAddPresenter >> initializeDialogWindow: aDialogPresenter [
	aDialogPresenter 
		title: 'Add User';
		initialExtent: 300@150;
		addButton: 'Cancel' do: [ :button | button close ];
		addButton: 'Add' do: [ :button | button beOk; close. ].
]

{ #category : 'as yet unclassified' }
UserAddPresenter >> initializePresenters [ 
	userNameInput := self newTextInput .
]

{ #category : 'as yet unclassified' }
UserAddPresenter >> newUserName [
	^userNameInput text
]
