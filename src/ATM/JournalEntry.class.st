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

{ #category : 'creating classes' }
JournalEntry class >> drAccount: aDrAccount crAccount: aCrAccount amount: anAmount note: aNote [
	^self new dateAndTime: DateAndTime now;
		drAccount: aDrAccount ;
		crAccount: aCrAccount ;
		amount: anAmount ;
		note: aNote .
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
