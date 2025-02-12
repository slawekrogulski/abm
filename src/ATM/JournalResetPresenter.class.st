"
Journal reset dialogue
"
Class {
	#name : 'JournalResetPresenter',
	#superclass : 'SpPresenter',
	#category : 'ATM-ui',
	#package : 'ATM',
	#tag : 'ui'
}

{ #category : 'layout' }
JournalResetPresenter >> defaultLayout [ 
	^SpBoxLayout newTopToBottom 
		add: (self newLabel label: 'Are you sure?');
		yourself. 
	
]

{ #category : 'initialization' }
JournalResetPresenter >> initializeDialogWindow: aDialogPresenter [
	aDialogPresenter 
		title: 'Confirm Journal Reset';
		initialExtent: 300@150;
		addButton: 'Cancel' do: [ :button | button close ];
		addButton: 'Reset' do: [ :button | button beOk; close. ].
]
