"
Atm Application class.
Contains entry point
To run in Playground
```language=Pharo
AtmApplication new start.
```

`AtmApplication>>#start`

script for running tests
```language=Pharo
""code goes here""
```
"
Class {
	#name : 'AtmApplication',
	#superclass : 'SpApplication',
	#instVars : [
		'journal',
		'journalEntryClass'
	],
	#classInstVars : [
		'presenters'
	],
	#category : 'ATM-application',
	#package : 'ATM',
	#tag : 'application'
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

{ #category : 'accessing' }
AtmApplication class >> start [
	self new start
]

{ #category : 'as yet unclassified' }
AtmApplication class >> updatePresenters [ 
	presenters keysAndValuesDo: [ 
		:key :presenter |
		Transcript show: ('UpdatePresenter {1}' format: {key}); cr. 
		presenter updatePresenter ]
]

{ #category : 'account ops' }
AtmApplication >> deposit: amount to: owner [
	|cashAccount bankAccount journalEntry|
	bankAccount := CashAtBankAccountId ownedBy: owner.
	cashAccount := CashOnHandAccountId ownedBy: owner.
	journalEntry := journalEntryClass drAccount: bankAccount crAccount: cashAccount amount: amount note: 'bank deposit'.
	journal add: journalEntry .
	self updatePresenters
]

{ #category : 'accessing' }
AtmApplication >> journal: aJournal [

	journal := aJournal
]

{ #category : 'accessing' }
AtmApplication >> journalEntryClass: aJournalEntryClass [

	journalEntryClass := aJournalEntryClass
]

{ #category : 'opening' }
AtmApplication >> openJournal [ 
	(self new: JournalPresenter) open.
]

{ #category : 'opening' }
AtmApplication >> openJournal: anOwner [
	(JournalPresenter newApplication: self owner: anOwner) open. 
	"(self new: JournalPresenter) open."
]

{ #category : 'opening' }
AtmApplication >> openUserAccounts: userAccounts [ 
	(UserAccountPresenter newApplication: self owner: self model: userAccounts) open .
]

{ #category : 'opening' }
AtmApplication >> openUserAccounts: userAccounts owner: anOwner [
	(UserAccountPresenter newApplication: self owner: anOwner model: userAccounts) open .
]

{ #category : 'account ops' }
AtmApplication >> post [ 
	journal post: Ledger.
	self updatePresenters.
]

{ #category : 'running' }
AtmApplication >> run [ 
	super run.
]

{ #category : 'running' }
AtmApplication >> start [
	|presenter|
	"^ ( self new: AtmMainPresenter  ) open".
	presenter := self new: AtmApplicationPresenter .
	"self class addPresenterToUpdate: presenter."
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

{ #category : 'account ops' }
AtmApplication >> transfer: amount from: sender to: recipient [
	|jeTransfer|
	jeTransfer := journalEntryClass 
		drAccount: (CashAtBankAccountId ownedBy: recipient) 
		crAccount: (CashAtBankAccountId ownedBy: sender)  
		amount: amount 
		note: ('transfer {1} from {2} to {3}' format: {amount . sender . recipient }). 
	journal add: jeTransfer.
	self updatePresenters .
]

{ #category : 'account ops' }
AtmApplication >> transferLater: amount from: sender to: recipient [
	|jeTransfer|
	jeTransfer := journalEntryClass 
		drAccount: (ReceivableAccountId ownedBy: recipient receivableFrom: sender)
		crAccount: (PayableAccountId    ownedBy: sender    payableTo:      recipient)
		amount: amount 
		note: ('transfer_later {1} from {2} to {3}' format: {amount . sender . recipient}). 
	journal add: jeTransfer.
	self updatePresenters .
]

{ #category : 'ui' }
AtmApplication >> updatePresenters [ 
	self windows do: [ :window | window presenter updatePresenter ]
]
