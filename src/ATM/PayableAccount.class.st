"
Payable Account
"
Class {
	#name : 'PayableAccount',
	#superclass : 'LiabilityAccount',
	#instVars : [
		'payee'
	],
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
}

{ #category : 'creating classes' }
PayableAccount class >> ownedBy: anOwner payableTo: aPayee [
	^(self ownedBy: anOwner) payee: aPayee 
]

{ #category : 'accessing' }
PayableAccount >> payee [

	^ payee
]

{ #category : 'accessing' }
PayableAccount >> payee: aPayee [

	payee := aPayee
]
