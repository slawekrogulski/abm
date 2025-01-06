Class {
	#name : 'TransferPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'amountInput',
		'recipientINput'
	],
	#category : 'ATM',
	#package : 'ATM'
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
			add: 'Recipient'; add: recipientINput.].
	^SpBoxLayout newTopToBottom 
		add: grid;
		yourself. 
	
]

{ #category : 'initialization' }
TransferPresenter >> initializeDialogWindow: aDialogPresenter [
	aDialogPresenter 
		title: 'Transfer';
		addButton: 'Cancel' do: [ :button | button close ];
		addButton: 'Transfer' do: [ :button | button beOk; close. ].
]

{ #category : 'initialization' }
TransferPresenter >> initializePresenters [ 
	amountInput := self newNumberInput .
	recipientINput := self newDropList 
		help: 'select recipient';
		items: ((Accounts accountNames) select: [:e | e ~= application loggedInUser ]).
]

{ #category : 'accessing' }
TransferPresenter >> recipient [
	^recipientINput selectedItem
]
