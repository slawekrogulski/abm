"
Id for PayableAccount
"
Class {
	#name : 'PayableAccountId',
	#superclass : 'AccountId',
	#instVars : [
		'payee'
	],
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
}

{ #category : 'creating classes' }
PayableAccountId class >> ownedBy: anOwner payableTo: aPayee [
	^(self ownedBy: anOwner) payee: aPayee 
]

{ #category : 'accessing' }
PayableAccountId >> payee [

	^ payee
]

{ #category : 'accessing' }
PayableAccountId >> payee: aPayee [

	payee := aPayee
]

{ #category : 'accessing' }
PayableAccountId >> thisAccount: userAccounts [
	^userAccounts payableTo: payee 
]

{ #category : 'accessing' }
PayableAccountId >> type [
	^'Payable_to_', payee 
]
