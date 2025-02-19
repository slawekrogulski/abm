Class {
	#name : 'JournalTest',
	#superclass : 'BaseTest',
	#category : 'ATM-Tests-tests',
	#package : 'ATM-Tests',
	#tag : 'tests'
}

{ #category : 'tests' }
JournalTest >> testJournal [
	journal add: (journalEntryClass 
		drAccount: (CashAtBankAccountId ownedBy: 'a')
		crAccount: (CashOnHandAccountId ownedBy: 'a')
		amount: 1 
		note: 'Deposit').
	journal entryCountIs: 1.
	userA balance: 1000000 cashOnHand: 1000000 cashAtBank: 0.
	journal post: ledger.
	userA balance: 1000000 cashOnHand: 999999 cashAtBank: 1.
	
]
