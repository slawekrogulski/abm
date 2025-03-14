"
subclass for verifying JournalEntry
"
Class {
	#name : 'JournalEntryUT',
	#superclass : 'JournalEntry',
	#traits : 'Tester',
	#category : 'ATM-Tests-UT extensions',
	#package : 'ATM-Tests',
	#tag : 'UT extensions'
}

{ #category : 'verification' }
JournalEntryUT >> id: anId amount: anAmount note: aNote drAccType: drAccountType drAccOwner: drAccountOwner crAccType: crAccountType crAccOwner: crAccountOwner [
	tester assert: id     equals: anId.
	tester assert: amount equals: anAmount .
	tester assert: note   equals: aNote .
	tester assert: drAccount type  equals: drAccountType .
	tester assert: drAccount owner equals: drAccountOwner .
	tester assert: crAccount type  equals: crAccountType .
	tester assert: crAccount owner equals: crAccountOwner .

]
