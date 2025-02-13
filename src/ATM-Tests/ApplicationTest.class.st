Class {
	#name : 'ApplicationTest',
	#superclass : 'TestCase',
	#instVars : [
		'application',
		'userA',
		'userB'
	],
	#category : 'ATM-Tests',
	#package : 'ATM-Tests'
}

{ #category : 'as yet unclassified' }
ApplicationTest >> journalEntryAccount: aAccountId isOwnedBy: anOwner isOfType: aType [
	self assert: aAccountId owner equals: anOwner .
	self assert: aAccountId type  equals: aType.
]

{ #category : 'running' }
ApplicationTest >> setUp [
	super setUp.
	application := AtmApplication new.
	Ledger testStart.
	Journal testStart .
	userA := UserAccounts newFor: 'a'.
	userB := UserAccounts newFor: 'b'.
	Ledger add: userA .
	Ledger add: userB .
]

{ #category : 'running' }
ApplicationTest >> tearDown [ 
	Ledger testStop.
	Journal testStop.
	super tearDown .

]

{ #category : 'tests' }
ApplicationTest >> testDeposit [
	|journalEntry|
	application deposit: 1 to: 'a'.
	self assert: userA balance equals: 1000000.
	self assert: userA cashAtBank balance equals: 0.
	self assert: userA cashOnHand balance equals: 1000000.
	self assert: Journal list size equals: 1.
	journalEntry := Journal list first.
	self assert: journalEntry id equals: 1.
	self deny: journalEntry posted.
	self assert: journalEntry amount equals: 1.
	self journalEntryAccount: journalEntry drAccount isOwnedBy: 'a' isOfType: 'Cash_At_Bank'.
	self journalEntryAccount: journalEntry crAccount isOwnedBy: 'a' isOfType: 'Cash_On_Hand'.
	application post.	
	self assert: journalEntry posted.
	self assert: userA balance equals: 1000000.
	self assert: userA cashAtBank balance equals: 1.
	self assert: userA cashOnHand balance equals: 999999.

]

{ #category : 'tests' }
ApplicationTest >> testTransfer [
	|journalEntry|
	application deposit: 1 to: 'a'.
	application transfer: 1 from: 'a' to: 'b'.
	self assert: Journal list size equals: 2.
	self deny: Journal list first posted.
	self deny: Journal list second posted.
	journalEntry := Journal list second.
	self assert: journalEntry id equals: 2.
	self deny: journalEntry posted.
	self assert: journalEntry amount equals: 1.
	self assert: journalEntry note equals: 'transfer 1 from a to b'.
	self journalEntryAccount: journalEntry drAccount isOwnedBy: 'b' isOfType: 'Cash_At_Bank'.
	self journalEntryAccount: journalEntry crAccount isOwnedBy: 'a' isOfType: 'Cash_At_Bank'.
	application post.
	self assert: Journal list first posted.
	self assert: Journal list second posted.
	self assert: userA balance            equals:  999999.
	self assert: userA cashOnHand balance equals:  999999.
	self assert: userA cashAtBank balance equals:       0.
	self assert: userB balance    equals:         1000001.
	self assert: userB cashOnHand balance equals: 1000000.
	self assert: userB cashAtBank balance equals:       1.

]
