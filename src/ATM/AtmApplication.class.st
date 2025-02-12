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
		'loggedInUser'
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

{ #category : 'accessing' }
AtmApplication >> accounts [
	^(Ledger accountsOf: (self loggedInUser)).
]

{ #category : 'account ops' }
AtmApplication >> balance [ 
	^Ledger balanceOf: (self loggedInUser)
]

{ #category : 'account ops' }
AtmApplication >> deposit: amount to: owner [
	|cashAccount bankAccount journalEntry|
	bankAccount := CashAtBankAccountId ownedBy: owner.
	cashAccount := CashOnHandAccountId ownedBy: owner.
	journalEntry := JournalEntry drAccount: bankAccount crAccount: cashAccount amount: amount note: 'bank deposit'.
	Journal add: journalEntry .
	self updatePresenters
]

{ #category : 'initialization' }
AtmApplication >> initialize [ 
	super initialize .
	"self styleSheet inspect."
]

{ #category : 'accessing' }
AtmApplication >> journalEntries [
	^Journal entriesFor: self loggedInUser.
]

{ #category : 'accessing' }
AtmApplication >> loggedInUser [

	^ loggedInUser
]

{ #category : 'accessing' }
AtmApplication >> loggedInUser: anObject [

	loggedInUser := anObject
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

{ #category : 'accessing' }
AtmApplication >> payables [ 
	^self accounts payables.
]

{ #category : 'account ops' }
AtmApplication >> post [ 
	Journal post: Ledger.
	self updatePresenters.
]

{ #category : 'accessing' }
AtmApplication >> receivables [ 
	^self accounts receivables.
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

{ #category : 'accessing' }
AtmApplication >> startMain [
	|presenter|
	"^ ( self new: AtmMainPresenter  ) open".
	presenter := self new: UserAccountPresenter.
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

{ #category : 'account ops' }
AtmApplication >> transfer: amount from: sender to: recipient [
	|jeTransfer senderAccountId recipientAccountId|
	senderAccountId := CashAtBankAccountId ownedBy: sender.
	recipientAccountId := CashAtBankAccountId ownedBy: recipient.
	jeTransfer := JournalEntry
		drAccount: recipientAccountId 
		crAccount: senderAccountId  
		amount: amount 
		note: ('transfer from {1} ro {2}' format: {sender . recipient }). 
	Journal add: jeTransfer.
	self updatePresenters .
]

{ #category : 'account ops' }
AtmApplication >> transfer: amount to: other [
	|jeTransfer|
	jeTransfer := JournalEntry 
		transfer: amount 
		from: (self loggedInUser) 
		to: other
		usingAvailableBalanceOf: self balance .
	Journal add: jeTransfer.
	self class updatePresenters .
]

{ #category : 'as yet unclassified' }
AtmApplication >> updatePresenters [ 
	self windows do: [ :window | window presenter updatePresenter ]
]
