Class {
	#name : 'UserAccountsTest',
	#superclass : 'TestCase',
	#category : 'ATM-Tests-tests',
	#package : 'ATM-Tests',
	#tag : 'tests'
}

{ #category : 'tests' }
UserAccountsTest >> testUserAccounts [
	|userAccount owner|
	owner := 'me'.
	userAccount := (UserAccountsUT newFor: owner) tester: self; yourself .
	self assert: userAccount owner equals: owner.
	userAccount balance: 1000000 cashOnHand: 1000000 cashAtBank: 0.
	self assert: userAccount payableBalance equals: 0.
	self assert: userAccount receivableBalance equals: 0.
	
	userAccount cashAtBank debit: 1.
	userAccount cashOnHand credit: 1.
	
	userAccount balance: 1000000 cashOnHand: 999999 cashAtBank: 1.

]
