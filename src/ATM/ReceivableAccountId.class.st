"
Id for ReceivableAccount
"
Class {
	#name : 'ReceivableAccountId',
	#superclass : 'AccountId',
	#instVars : [
		'payer'
	],
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
}

{ #category : 'creating classes' }
ReceivableAccountId class >> ownedBy: anOwner receivableFrom: aPayer [
	^(self ownedBy: anOwner) payer: aPayer 
]

{ #category : 'accessing' }
ReceivableAccountId >> payer [

	^ payer
]

{ #category : 'accessing' }
ReceivableAccountId >> payer: aPayer [

	payer := aPayer
]

{ #category : 'accessing' }
ReceivableAccountId >> thisAccount: userAccounts [
	^userAccounts receivableFrom: payer 
]

{ #category : 'accessing' }
ReceivableAccountId >> type [
	^'Receivable_from_', payer
]
