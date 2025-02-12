"
Liability account hierarchy
"
Class {
	#name : 'LiabilityAccount',
	#superclass : 'Account',
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
}

{ #category : 'account operations' }
LiabilityAccount >> credit: anAmount [
	balance := balance + anAmount 
]

{ #category : 'account operations' }
LiabilityAccount >> debit: anAmount [
	balance := balance - anAmount 
"	(balance >= anAmount)
		ifTrue: [ 
			balance := balance - anAmount.
			^anAmount ]
		ifFalse: [ ^0 ]"
]
