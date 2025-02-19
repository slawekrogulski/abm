Class {
	#name : 'ApplicationTest',
	#superclass : 'BaseTest',
	#category : 'ATM-Tests-tests',
	#package : 'ATM-Tests',
	#tag : 'tests'
}

{ #category : 'tests' }
ApplicationTest >> testDeposit [

	userA deposit: 1 via: application .
	userA balance: 1000000 cashOnHand: 1000000 cashAtBank: 0. 
	journal entryCountIs: 1.
	journal nonePosted .
	
	journal first id: 1 amount: 1 note: 'bank deposit' 
		drAccType: 'Cash_At_Bank' drAccOwner: 'a' 
		crAccType: 'Cash_On_Hand' crAccOwner: 'a'.
	
	application post.
	journal allPosted.
	userA balance: 1000000 cashOnHand: 999999 cashAtBank: 1.

]

{ #category : 'tests' }
ApplicationTest >> testTransfer [

	application deposit: 1 to: 'a'.
	application transfer: 1 from: 'a' to: 'b'.

	journal entryCountIs: 2.
	journal nonePosted.

	journal second id: 2 amount: 1 note: 'transfer 1 from a to b'
		drAccType: 'Cash_At_Bank' drAccOwner: 'b' 
		crAccType: 'Cash_At_Bank' crAccOwner: 'a'.

	application post.
	journal allPosted.
	userA balance:  999999 cashOnHand:  999999 cashAtBank: 0.
	userB balance: 1000001 cashOnHand: 1000000 cashAtBank: 1.

]

{ #category : 'tests' }
ApplicationTest >> testTransferNoFunds [

	userA transfer: 1 to: 'b' via: application .

	self assert: journal count equals: 1.
	journal nonePosted.
	journal first id: 1 amount: 1 note: 'transfer_later 1 from a to b'
		drAccType: 'Receivable_from_a' drAccOwner: 'b'
		crAccType: 'Payable_to_b'      crAccOwner: 'a'.

	application post.
	journal allPosted .
	userA balance: 1000000 cashOnHand: 1000000 cashAtBank: 0.
	userB balance: 1000000 cashOnHand: 1000000 cashAtBank: 0.
	
	userA payable:    1 to:   'b'.
	userB receivable: 1 from: 'a'.

]

{ #category : 'tests' }
ApplicationTest >> testTransferPartialFunds [

	application deposit: 1 to: 'a'.
	application post.
	userA transfer: 2 to: 'b' via: application .
	journal entryCountIs: 3.
	journal nonePostedAfter: 1.
	journal second id: 2 amount: 1 note: 'transfer 1 from a to b'
		drAccType: 'Cash_At_Bank' drAccOwner: 'b' 
		crAccType: 'Cash_At_Bank' crAccOwner: 'a'.

	journal third id: 3 amount: 1 note: 'transfer_later 1 from a to b'
		drAccType: 'Receivable_from_a' drAccOwner: 'b'
		crAccType: 'Payable_to_b'      crAccOwner: 'a'.

	application post.
	journal allPosted .
	userA balance:  999999 cashOnHand:  999999 cashAtBank: 0.
	userB balance: 1000001 cashOnHand: 1000000 cashAtBank: 1.
	
	userA payable:    1 to:   'b'.
	userB receivable: 1 from: 'a'.

]
