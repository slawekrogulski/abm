"
AccountId hierachy
"
Class {
	#name : 'AccountId',
	#superclass : 'Object',
	#instVars : [
		'owner'
	],
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
}

{ #category : 'testing' }
AccountId class >> isAbstract [

	^ self == AccountId
]

{ #category : 'creating classes' }
AccountId class >> ownedBy: owner [
	^self new owner: owner
]

{ #category : 'accessing' }
AccountId >> from: ledger [
	|userAccounts|
	userAccounts := ledger accountsOf: owner.
	^self thisAccount: userAccounts .
]

{ #category : 'accessing' }
AccountId >> name [
	^owner, '-', (self type)
]

{ #category : 'accessing' }
AccountId >> owner [
	^owner
]

{ #category : 'accessing' }
AccountId >> owner: anOwner [
	owner := anOwner
]

{ #category : 'accessing' }
AccountId >> thisAccount: userAccounts [
	self subclassResponsibility 
]

{ #category : 'accessing' }
AccountId >> type [
	self subclassResponsibility 
]
