"
Cash on Hand Id
"
Class {
	#name : 'CashOnHandAccountId',
	#superclass : 'AccountId',
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
}

{ #category : 'creating classes' }
CashOnHandAccountId class >> ownedBy: owner [
	^self new owner: owner
]

{ #category : 'accessing' }
CashOnHandAccountId >> thisAccount: userAccounts [
	^userAccounts cashOnHand 
]

{ #category : 'accessing' }
CashOnHandAccountId >> type [
	^'Cash_On_Hand' 
]
