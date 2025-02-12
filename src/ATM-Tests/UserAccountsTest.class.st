Class {
	#name : 'UserAccountsTest',
	#superclass : 'TestCase',
	#category : 'ATM-Tests',
	#package : 'ATM-Tests'
}

{ #category : 'tests' }
UserAccountsTest >> testUserAccounts [
	|userAccount owner|
	owner := 'me'.
	userAccount := UserAccounts newFor: owner.
	self assert: userAccount owner equals: owner.
	self assert: userAccount balance equals: 1000000.
	self assert: userAccount payable equals: 0.
	self assert: userAccount receivable equals: 0.
]
