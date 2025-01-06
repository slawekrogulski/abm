Class {
	#name : 'JournalEntryPayable',
	#superclass : 'JournalEntry',
	#instVars : [
		'to'
	],
	#category : 'ATM',
	#package : 'ATM'
}

{ #category : 'operations' }
JournalEntryPayable class >> credit: anAmount to: accountOwner [
	|owner to|
	owner := (accountOwner splitOn: $|) first.
	to := (accountOwner splitOn: $|) second.
	^(self operation: #credit amount: anAmount owner: owner) to: to; yourself .
]

{ #category : 'accessing' }
JournalEntryPayable >> accountName [ 
	^to
]

{ #category : 'accessing' }
JournalEntryPayable >> accountType [

	^ #payable
]

{ #category : 'as yet unclassified' }
JournalEntryPayable >> retrieveAccountFrom: accounts [
	^((accounts for: accountName) at: (self accountType )) at: to ifAbsentPut: [ Account new ]
]

{ #category : 'accessing' }
JournalEntryPayable >> to: name [ 
	to := name
]
