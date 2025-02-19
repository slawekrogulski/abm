Class {
	#name : 'AccountTest',
	#superclass : 'TestCase',
	#instVars : [
		'account'
	],
	#category : 'ATM-Tests-tests',
	#package : 'ATM-Tests',
	#tag : 'tests'
}

{ #category : 'basic tests' }
AccountTest >> testAccount [
	account := CashAtBank ownedBy: 'me'.
	self assert: account balance equals: 0
]

{ #category : 'basic tests' }
AccountTest >> testAccountCredit [
	account := CashAtBank ownedBy: 'me'.
	account credit: 100.
	self assert: account balance equals: -100
]

{ #category : 'basic tests' }
AccountTest >> testAccountDebit [
	account := CashAtBank ownedBy: 'me'.
	account debit: 100.
	self assert: (account balance) equals: 100.
"	self assert: account balance equals: 0.
	account credit: 1000.
	self assert: (account debit: 100) equals: 100.
	self assert: (account balance) equals: 900."
]
