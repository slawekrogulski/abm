Class {
	#name : 'LedgerTest',
	#superclass : 'BaseTest',
	#category : 'ATM-Tests-tests',
	#package : 'ATM-Tests',
	#tag : 'tests'
}

{ #category : 'initialization' }
LedgerTest >> setUpAccounts [ 
	"do nothing"
]

{ #category : 'tests' }
LedgerTest >> testAddRemoveUserAccount [
	|owner|
	owner := 'me'.
	ledger add: (UserAccountsUT newFor: owner).
	self assert: (ledger accountsOf: owner) owner equals: owner.
	self assert: (ledger balanceOf: owner) equals: 1000000.
	ledger remove: owner.
	self deny: (ledger exists: owner).
	ledger isEmpty.
]

{ #category : 'tests' }
LedgerTest >> testListAccounts [
	|owner|
	owner := 'me'.
	self deny: ((ledger list) includes: owner).
	ledger add: (UserAccounts newFor: owner).
	self assert: (ledger list size) equals: 1.
	self assert: (ledger exists: owner).
	ledger remove: owner.
	self deny: (ledger exists: owner).
	
	"accounts := Ledger accuontsOf: owner.
	self assert: accounts owner equals: owner.
	Ledger remove: owner.
	self deny: (Ledger exists: owner)"
]
