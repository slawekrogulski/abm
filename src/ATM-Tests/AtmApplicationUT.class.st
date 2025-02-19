"
AtmApplication tester
"
Class {
	#name : 'AtmApplicationUT',
	#superclass : 'AtmApplication',
	#category : 'ATM-Tests-UT extensions',
	#package : 'ATM-Tests',
	#tag : 'UT extensions'
}

{ #category : 'accessing' }
AtmApplicationUT >> journal: aJournal [

	journal := aJournal
]

{ #category : 'accessing' }
AtmApplicationUT >> journalEntryClass: aJournalEntryClass [

	journalEntryClass := aJournalEntryClass
]

{ #category : 'accessing' }
AtmApplicationUT >> ledger: aLedger [
	ledger := aLedger
]
