Class {
	#name : 'JournalEntry',
	#superclass : 'Object',
	#instVars : [
		'id',
		'accountName',
		'transactionType',
		'amount',
		'dateAndTime',
		'posted'
	],
	#category : 'ATM',
	#package : 'ATM'
}

{ #category : 'operations' }
JournalEntry class >> credit: anAmount to: accountOwner [
	^self operation: #credit amount: anAmount owner: accountOwner .

]

{ #category : 'operations' }
JournalEntry class >> debit: anAmount from: accountOwner [
	^self operation: #debit amount: anAmount owner: accountOwner .

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
JournalEntry >> accountName [

	^ accountName
]

{ #category : 'accessing' }
JournalEntry >> accountName: anObject [

	accountName := anObject
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
	^('{1}-{2}-{3]' format: {
		dateAndTime year . 
		dateAndTime month . 
		dateAndTime dayOfMonth })  
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
JournalEntry >> name [ 
	^accountName 
]

{ #category : 'accessing' }
JournalEntry >> owner [ 
	^accountName 
]

{ #category : 'as yet unclassified' }
JournalEntry >> postTo: account [

	posted ifTrue: [ ^ self ].
	account perform: (transactionType, ':') with: amount .
	posted := true
]

{ #category : 'accessing' }
JournalEntry >> posted [ 
	^posted ifTrue: [ 'Y' ] ifFalse: [ 'N' ]
]

{ #category : 'as yet unclassified' }
JournalEntry >> retrieveAccountFrom: accounts [
	^(accounts for: accountName) at: (self accountType )
]

{ #category : 'accessing' }
JournalEntry >> time [
	^('{1}-{2}-{3}' format: {
		dateAndTime hours .
		dateAndTime minutes .
		dateAndTime seconds})  
]

{ #category : 'accessing' }
JournalEntry >> transactionType [

	^ transactionType
]

{ #category : 'accessing' }
JournalEntry >> transactionType: anObject [

	transactionType := anObject
]
