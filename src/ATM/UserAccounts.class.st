"
User Account container.
"
Class {
	#name : 'UserAccounts',
	#superclass : 'Model',
	#instVars : [
		'owner',
		'payable',
		'receivable',
		'cashAtBank',
		'cashOnHand'
	],
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
}

{ #category : 'instance creation' }
UserAccounts class >> newFor: owner [
	^self basicNew owner: owner; initialize 
]

{ #category : 'accessing' }
UserAccounts >> accountBalances [ 
	|oc|
	oc := OrderedCollection new.
	oc add: (Association key: 'Cash on Hand' value: cashOnHand ).
	oc add: (Association key: 'Cash at Bank' value: cashAtBank ).
	^oc
]

{ #category : 'account ops' }
UserAccounts >> balance [
	^cashAtBank balance + cashOnHand balance.
]

{ #category : 'accessing' }
UserAccounts >> cashAtBank [ 
	^cashAtBank 
]

{ #category : 'accessing' }
UserAccounts >> cashOnHand [
	^cashOnHand 
]

{ #category : 'initialization' }
UserAccounts >> initialize [ 
	cashAtBank := CashAtBank ownedBy: owner.
	cashOnHand := CashOnHand ownedBy: owner.
	cashOnHand debit: 1000000.
	payable := Dictionary new.
	receivable := Dictionary new.
]

{ #category : 'accessing' }
UserAccounts >> owner [
	^ owner
]

{ #category : 'accessing' }
UserAccounts >> owner: anOwner [ 
	owner := anOwner.
]

{ #category : 'accessing' }
UserAccounts >> payable [ 
	^payable values inject: 0 into: [ :acc :each | acc + each ]
]

{ #category : 'accessing' }
UserAccounts >> payables [
	^payable
]

{ #category : 'accessing' }
UserAccounts >> receivable [ 
	^receivable values inject: 0 into: [ :acc :each | acc + each ]
]

{ #category : 'accessing' }
UserAccounts >> receivables [
	^receivable
]
