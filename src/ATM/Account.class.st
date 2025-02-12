"
Top of the Account hierarchy
"
Class {
	#name : 'Account',
	#superclass : 'Object',
	#instVars : [
		'owner',
		'balance'
	],
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
}

{ #category : 'creating classes' }
Account class >> ownedBy: anOwner [
	^self new owner: anOwner 
]

{ #category : 'account operations' }
Account >> balance [
	^balance
]

{ #category : 'account operations' }
Account >> credit: anAmount [
	self subclassResponsibility 
]

{ #category : 'account operations' }
Account >> debit: anAmount [
	self subclassResponsibility 
"	(balance >= anAmount)
		ifTrue: [ 
			balance := balance - anAmount.
			^anAmount ]
		ifFalse: [ ^0 ]"
]

{ #category : 'initialization' }
Account >> initialize [ 
	super initialize .
	balance := 0.
]

{ #category : 'accessing' }
Account >> owner: anOwner [
	owner := anOwner 
]
