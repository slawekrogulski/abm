"
Asset Account hierarchy
"
Class {
	#name : 'AssetAccount',
	#superclass : 'Account',
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
}

{ #category : 'account operations' }
AssetAccount >> credit: anAmount [
	balance := balance - anAmount 
]

{ #category : 'account operations' }
AssetAccount >> debit: anAmount [
	balance := balance + anAmount 
"	(balance >= anAmount)
		ifTrue: [ 
			balance := balance - anAmount.
			^anAmount ]
		ifFalse: [ ^0 ]"
]
