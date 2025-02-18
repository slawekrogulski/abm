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

{ #category : 'account ops' }
UserAccounts >> deposit: anAmount via: application [
	application deposit: anAmount to: owner
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
UserAccounts >> payableBalance [
	^payable values inject: 0 into: [ :acc :each | acc + each balance ]
]

{ #category : 'accessing' }
UserAccounts >> payableTo: payee [
	^payable at: payee ifAbsentPut: [ PayableAccount ownedBy: owner payableTo: payee]
]

{ #category : 'accessing' }
UserAccounts >> payables [
	^payable
]

{ #category : 'accessing' }
UserAccounts >> receivableBalance [
	^receivable values inject: 0 into: [ :acc :each | acc + each balance]
]

{ #category : 'accessing' }
UserAccounts >> receivableFrom: payer [
	^receivable at: payer ifAbsentPut: [ ReceivbleAccount ownedBy: owner receivableFrom: payer ]
]

{ #category : 'accessing' }
UserAccounts >> receivables [
	^receivable
]

{ #category : 'account ops' }
UserAccounts >> transfer: anAmount to: recipient via: application [
	| available |
	available := cashAtBank balance.
	available >= anAmount ifTrue: [
		application transfer: anAmount from: owner to: recipient ].
	available = 0 ifTrue: [
		application transferLater: anAmount from: owner to: recipient ].
	(available > 0 and: [ available < anAmount ]) ifTrue: [
		application transfer: available from: owner to: recipient.
		application transferLater: anAmount - available from: owner to: recipient ].
]
