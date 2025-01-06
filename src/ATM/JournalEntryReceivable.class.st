Class {
	#name : 'JournalEntryReceivable',
	#superclass : 'JournalEntry',
	#instVars : [
		'from'
	],
	#category : 'ATM',
	#package : 'ATM'
}

{ #category : 'operations' }
JournalEntryReceivable class >> credit: anAmount to: accountOwner [
	|owner from|
	owner := (accountOwner splitOn: $|) first.
	from := (accountOwner splitOn: $|) second.
	^(self operation: #credit amount: anAmount owner: owner) from: from; yourself .
]

{ #category : 'accessing' }
JournalEntryReceivable >> accountName [ 
	^from
]

{ #category : 'accessing' }
JournalEntryReceivable >> accountType [

	^ #receivable
]

{ #category : 'accessing' }
JournalEntryReceivable >> from: anObject [

	from := anObject
]

{ #category : 'as yet unclassified' }
JournalEntryReceivable >> retrieveAccountFrom: accounts [
	^((accounts for: accountName) at: (self accountType )) at: from ifAbsentPut: [ Account new ]
]
