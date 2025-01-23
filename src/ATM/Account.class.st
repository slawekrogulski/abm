Class {
	#name : 'Account',
	#superclass : 'Object',
	#instVars : [
		'balance'
	],
	#category : 'ATM',
	#package : 'ATM'
}

{ #category : 'account operations' }
Account >> balance [
	^balance
]

{ #category : 'account operations' }
Account >> credit: anAmount [
	balance := balance + anAmount
]

{ #category : 'account operations' }
Account >> debit: anAmount [
	(balance >= anAmount)
		ifTrue: [ 
			balance := balance - anAmount.
			^anAmount ]
		ifFalse: [ ^0 ]
]

{ #category : 'initialization' }
Account >> initialize [ 
	super initialize .
	balance := 0.
]
