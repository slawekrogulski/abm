Class {
	#name : 'AccountTest',
	#superclass : 'TestCase',
	#instVars : [
		'account'
	],
	#category : 'ATM-Tests',
	#package : 'ATM-Tests'
}

{ #category : 'running' }
AccountTest >> setUp [
	super setUp.

	account := Account new.

]

{ #category : 'basic tests' }
AccountTest >> testAccount [
  self assert: account balance equals: 0
]

{ #category : 'basic tests' }
AccountTest >> testAccountCredit [
	account credit: 100.
	self assert: account balance equals: 100
]

{ #category : 'basic tests' }
AccountTest >> testAccountDebit [
	self assert: (account debit: 100) equals: 0.
	self assert: account balance equals: 0.
	account credit: 1000.
	self assert: (account debit: 100) equals: 100.
	self assert: (account balance) equals: 900.
]
