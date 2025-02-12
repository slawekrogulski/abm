"
JOurnal Entry
"
Class {
	#name : 'JournalEntry',
	#superclass : 'Object',
	#instVars : [
		'id',
		'dateAndTime',
		'drAccount',
		'crAccount',
		'amount',
		'posted',
		'note'
	],
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
}

{ #category : 'operations' }
JournalEntry class >> credit: anAmount to: accountOwner [
	^self operation: #credit amount: anAmount owner: accountOwner .

]

{ #category : 'operations' }
JournalEntry class >> debit: anAmount from: accountOwner [
	^self operation: #debit amount: anAmount owner: accountOwner .

]

{ #category : 'creating classes' }
JournalEntry class >> drAccount: aDrAccount crAccount: aCrAccount amount: anAmount note: aNote [
	^self new dateAndTime: DateAndTime now;
		drAccount: aDrAccount ;
		crAccount: aCrAccount ;
		amount: anAmount ;
		note: aNote .
]

{ #category : 'operations' }
JournalEntry class >> operation: op amount: anAmount owner: accountOwner [
	^self new
		accountName: accountOwner ;
		amount: anAmount ;
		dateAndTime: DateAndTime now;
		transactionType: op.
]

{ #category : 'operations' }
JournalEntry class >> transfer: anAmount from: sender to: recipient [
	^{
		self debit: anAmount from: sender .
		self credit: anAmount to: recipient 
	}
]

{ #category : 'operations' }
JournalEntry class >> transfer: transferAmount from: sender to: recipient usingAvailableBalanceOf: availableBalance [
	(availableBalance >= transferAmount)
		ifTrue: [^{
			self debit: transferAmount from: sender .
			self credit: transferAmount to: recipient }].
	((availableBalance > 0) and: [availableBalance < transferAmount ])	ifTrue: [ ^{ 
			self debit: availableBalance from: sender .
			JournalEntryPayable credit: (transferAmount - availableBalance ) to: (sender,'|',recipient). 
			JournalEntryReceivable credit: (transferAmount - availableBalance) to: (recipient,'|',sender) .
			self credit: availableBalance to: recipient } ].
	^{
		JournalEntryPayable credit: (transferAmount - availableBalance ) to: (sender,'|',recipient). 
		JournalEntryReceivable credit: (transferAmount - availableBalance) to: (recipient,'|',sender) .
	}
]

{ #category : 'accessing' }
JournalEntry >> accountType [

	^ #cash
]

{ #category : 'accessing' }
JournalEntry >> amount [

	^ amount
]

{ #category : 'accessing' }
JournalEntry >> amount: anObject [

	amount := anObject
]

{ #category : 'accessing' }
JournalEntry >> crAccount [

	^ crAccount
]

{ #category : 'accessing' }
JournalEntry >> crAccount: anObject [

	crAccount := anObject
]

{ #category : 'as yet unclassified' }
JournalEntry >> dataAndTimeString [
	^('{1}-{2}-{3] {4}:{5}:{6}' format: {
		dateAndTime year . 
		dateAndTime month . 
		dateAndTime dayOfMonth .
		dateAndTime hours .
		dateAndTime minutes .
		dateAndTime seconds})  
]

{ #category : 'accessing' }
JournalEntry >> date [
	^$- join: (
		{ #year .  #month . #dayOfMonth } 
			collect: [ :m | (dateAndTime perform: m) zeroPadded ])

]

{ #category : 'accessing' }
JournalEntry >> dateAndTime [

	^ dateAndTime
]

{ #category : 'accessing' }
JournalEntry >> dateAndTime: anObject [

	dateAndTime := anObject
]

{ #category : 'accessing' }
JournalEntry >> drAccount [

	^ drAccount
]

{ #category : 'accessing' }
JournalEntry >> drAccount: anObject [

	drAccount := anObject
]

{ #category : 'accessing' }
JournalEntry >> id [
	^id
]

{ #category : 'accessing' }
JournalEntry >> id: nextId [
	id := nextId .
	^self
]

{ #category : 'initialization' }
JournalEntry >> initialize [ 
	super initialize .
	posted := false.
]

{ #category : 'accessing' }
JournalEntry >> note [

	^ note
]

{ #category : 'accessing' }
JournalEntry >> note: anObject [

	note := anObject
]

{ #category : 'as yet unclassified' }
JournalEntry >> post: ledger [

	posted ifTrue: [ ^ self ].
	ledger debit: drAccount by: amount .
	ledger credit: crAccount by: amount . 
	posted := true
]

{ #category : 'accessing' }
JournalEntry >> posted [ 
	^posted ifTrue: [ 'Y' ] ifFalse: [ 'N' ]
]

{ #category : 'accessing' }
JournalEntry >> time [
	^$: join: (
		{ #hours .  #minutes . #seconds } 
			collect: [ :m | (dateAndTime perform: m) zeroPadded ])
]
