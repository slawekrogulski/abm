"
Receivable Account
"
Class {
	#name : 'ReceivbleAccount',
	#superclass : 'AssetAccount',
	#instVars : [
		'payer'
	],
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
}

{ #category : 'creating classes' }
ReceivbleAccount class >> ownedBy: anOwner receivableFrom: aPayer [
	^(self ownedBy: anOwner) payer: aPayer 
]

{ #category : 'accessing' }
ReceivbleAccount >> payer [

	^ payer
]

{ #category : 'accessing' }
ReceivbleAccount >> payer: aPayer [

	payer := aPayer
]
