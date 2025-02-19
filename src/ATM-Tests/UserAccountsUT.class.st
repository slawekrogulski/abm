"
testable user accunts
"
Class {
	#name : 'UserAccountsUT',
	#superclass : 'UserAccounts',
	#traits : 'Tester',
	#classTraits : 'Tester classTrait',
	#category : 'ATM-Tests-UT extensions',
	#package : 'ATM-Tests',
	#tag : 'UT extensions'
}

{ #category : 'verification' }
UserAccountsUT >> balance: aBalance cashOnHand: aCashOnHand cashAtBank: aCashAtBank [
	tester assert: self       balance equals: aBalance .
	tester assert: cashOnHand balance equals: aCashOnHand .
	tester assert: cashAtBank balance equals: aCashAtBank .
]

{ #category : 'verification' }
UserAccountsUT >> payable: aBalance to: receiver [
	tester assert: (payable at: receiver) balance equals: aBalance 
]

{ #category : 'verification' }
UserAccountsUT >> receivable: aBalance from: sender [
	tester assert: (receivable at: sender) balance equals: aBalance 
]

{ #category : 'verification' }
UserAccountsUT >> receivableFrom: sender balance: aBalance [
	tester assert: (receivable at: sender) balance equals: aBalance 
]
