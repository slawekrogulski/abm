"
Transfer dialogue
"
Class {
	#name : 'TransferPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'amountInput',
		'recipientInput'
	],
	#category : 'ATM-ui',
	#package : 'ATM',
	#tag : 'ui'
}

{ #category : 'accessing' }
TransferPresenter >> amount [
	^amountInput number
]

{ #category : 'layout' }
TransferPresenter >> defaultLayout [ 
	|grid |
	grid := SpGridLayout build: [ :builder |
		builder
			column: 2 expand: false; 
			add: 'Amount'; add: amountInput ; nextRow;
			add: 'Recipient'; add: recipientInput.].
	^SpBoxLayout newTopToBottom 
		add: grid;
		yourself. 
	
]

{ #category : 'initialization' }
TransferPresenter >> initializeDialogWindow: aDialogPresenter [
	aDialogPresenter 
		title: 'Transfer';
		initialExtent: 300@180;
		addButton: 'Cancel' do: [ :button | button close ];
		addButton: 'Transfer' do: [ :button | button beOk; close. ].
]

{ #category : 'initialization' }
TransferPresenter >> initializePresenters [ 
	amountInput := self newNumberInput .
	recipientInput := self newDropList 
		help: 'select recipient'";
		items: ((Ledger users) select: [:e | e ~= application loggedInUser ])".
]

{ #category : 'accessing' }
TransferPresenter >> recipient [
	^recipientInput selectedItem
]

{ #category : 'accessing' }
TransferPresenter >> recipients: recipeints [
	recipientInput items: recipeints 
]
