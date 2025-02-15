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

{ #category : 'accessing' }
ReceivbleAccount >> payer [

	^ payer
]

{ #category : 'accessing' }
ReceivbleAccount >> payer: aPayer [

	payer := aPayer
]
