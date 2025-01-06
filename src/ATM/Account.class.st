Class {
	#name : 'Account',
	#superclass : 'Object',
	#instVars : [
		'balance'
	],
	#category : 'ATM',
	#package : 'ATM'
}

{ #category : 'as yet unclassified' }
Account >> balance [
	^balance
]

{ #category : 'as yet unclassified' }
Account >> credit: anAmount [
	balance := balance + anAmount
]

{ #category : 'as yet unclassified' }
Account >> debit: anAmount [
	balance := balance - anAmount
]

{ #category : 'initialization' }
Account >> initialize [ 
	super initialize .
	balance := 0.
]
