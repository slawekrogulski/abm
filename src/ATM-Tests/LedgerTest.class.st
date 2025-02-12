Class {
	#name : 'LedgerTest',
	#superclass : 'TestCase',
	#category : 'ATM-Tests',
	#package : 'ATM-Tests'
}

{ #category : 'tests' }
LedgerTest >> testAddRemoveUserAccount [
	|owner|
	owner := 'me'.
	Ledger add: (UserAccounts newFor: owner).
	self assert: (Ledger accountsOf: owner) owner equals: owner.
	self assert: (Ledger balanceOf: owner) equals: 1000000.
	Ledger remove: owner.
	self deny: (Ledger exists: owner)
]

{ #category : 'tests' }
LedgerTest >> testListAccounts [
	|owner|
	owner := 'me'.
	self deny: ((Ledger list) includes: owner).
	Ledger add: (UserAccounts newFor: owner).
	self assert: (Ledger exists: owner).
	Ledger remove: owner.
	self deny: (Ledger exists: owner).
	
	"accounts := Ledger accuontsOf: owner.
	self assert: accounts owner equals: owner.
	Ledger remove: owner.
	self deny: (Ledger exists: owner)"
]
