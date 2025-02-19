"
Ledger tester
"
Class {
	#name : 'LedgerUT',
	#superclass : 'Ledger',
	#classTraits : 'Tester',
	#classInstVars : [
		'prodUserAccounts',
		'underTest'
	],
	#category : 'ATM-Tests-UT extensions',
	#package : 'ATM-Tests',
	#tag : 'UT extensions'
}

{ #category : 'testing' }
LedgerUT class >> isEmpty [ 
	tester assert: self list isEmpty.
]

{ #category : 'testing' }
LedgerUT class >> testInProgress [
	^underTest.
]

{ #category : 'testing' }
LedgerUT class >> testStart [
	underTest := true.
	prodUserAccounts := userAccounts .
	self initialize.
"	userAccounts := Dictionary new ."
]

{ #category : 'testing' }
LedgerUT class >> testStop [
	underTest := false.
	userAccounts := prodUserAccounts .
]
