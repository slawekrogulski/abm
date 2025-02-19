Class {
	#name : 'BaseTest',
	#superclass : 'TestCase',
	#instVars : [
		'application',
		'userA',
		'userB',
		'journal',
		'ledger',
		'userAccountsClass',
		'journalEntryClass'
	],
	#category : 'ATM-Tests-base',
	#package : 'ATM-Tests',
	#tag : 'base'
}

{ #category : 'running' }
BaseTest >> setUp [
	super setUp.
	userAccountsClass := UserAccountsUT .
	journalEntryClass := JournalEntryUT .
	journal := JournalUT.
	journal tester: self.
	journal testStart.
	
	ledger := LedgerUT.
	ledger tester: self.
	ledger testStart.
	
	application := AtmApplicationUT new.
	application journal: journal.
	application journalEntryClass: journalEntryClass .
	application ledger: ledger.
	
	self setUpAccounts .

]

{ #category : 'initialization' }
BaseTest >> setUpAccounts [
	userA := (userAccountsClass newFor: 'a') tester: self.
	userB := (userAccountsClass newFor: 'b') tester: self.
	ledger add: userA .
	ledger add: userB .
]

{ #category : 'running' }
BaseTest >> tearDown [ 
	ledger testStop.
	journal testStop.	
	super tearDown.
]
