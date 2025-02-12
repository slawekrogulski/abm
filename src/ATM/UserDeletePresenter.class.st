"
Delete user dialogue
"
Class {
	#name : 'UserDeletePresenter',
	#superclass : 'SpPresenter',
	#category : 'ATM-ui',
	#package : 'ATM',
	#tag : 'ui'
}

{ #category : 'layout' }
UserDeletePresenter >> defaultLayout [ 
	^SpBoxLayout newTopToBottom 
		add: (self newLabel label: 'Are you sure?');
		yourself. 
	
]

{ #category : 'initialization' }
UserDeletePresenter >> initializeDialogWindow: aDialogPresenter [
	aDialogPresenter 
		title: 'Confirm User Delete';
		initialExtent: 300@150;
		addButton: 'Cancel' do: [ :button | button close ];
		addButton: 'Delete' do: [ :button | button beOk; close. ].
]
