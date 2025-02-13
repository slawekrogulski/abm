"
Deposit dialog
"
Class {
	#name : 'DepositPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'amountInput'
	],
	#category : 'ATM-ui',
	#package : 'ATM',
	#tag : 'ui'
}

{ #category : 'layout' }
DepositPresenter >> defaultLayout [ 
	|grid |
	grid := SpGridLayout build: [ :builder |
		builder
			column: 2 expand: false; 
			add: 'Amount'; add: amountInput ].
	^SpBoxLayout newTopToBottom 
		add: grid;
		yourself. 
	
]

{ #category : 'as yet unclassified' }
DepositPresenter >> depositAmount [
	^amountInput number.
]

{ #category : 'initialization' }
DepositPresenter >> initializeDialogWindow: aDialogPresenter [
	aDialogPresenter 
		title: 'Deposit';
		initialExtent: 300@150;
		addButton: 'Cancel' do: [ :button | button close ];
		addButton: 'Deposit' do: [ :button | button beOk; close. ].
]

{ #category : 'as yet unclassified' }
DepositPresenter >> initializePresenters [ 
	amountInput := self newNumberInput .
]
