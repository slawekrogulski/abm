"
Cash At Bank Id
"
Class {
	#name : 'CashAtBankAccountId',
	#superclass : 'AccountId',
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
}

{ #category : 'accessing' }
CashAtBankAccountId >> thisAccount: userAccounts [
	^userAccounts cashAtBank.
]

{ #category : 'accessing' }
CashAtBankAccountId >> type [
	^'Cash_At_Bank'
]
