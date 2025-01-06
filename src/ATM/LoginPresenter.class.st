Class {
	#name : 'LoginPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'userNameTextInput',
		'loginButtom',
		'onLoginSuccess'
	],
	#category : 'ATM',
	#package : 'ATM'
}

{ #category : 'layout' }
LoginPresenter >> defaultLayout [ 
	^SpBoxLayout newVertical 
		add: (SpGridLayout build: [ :builder |
			builder 
				add: 'Login:'; add: userNameTextInput ; nextRow ;
				add: loginButtom span: 2@1.
				]);
			yourself .
]

{ #category : 'initialization' }
LoginPresenter >> initializePresenters [ 
	userNameTextInput := self newTextInput .
	loginButtom := self newButton label: 'Login'.
	"loginButtom action: [ onLoginSuccess value: userNameTextInput text ]."
	
]

{ #category : 'initialization' }
LoginPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: 'ATM login'.
	loginButtom action: [
		|userName|
		userName := userNameTextInput text.
		aWindowPresenter close.
		application loggedInUser: userName.
		Accounts initializeFor: userName .
		application startMain ]
]

{ #category : 'accessing' }
LoginPresenter >> onLoginSuccess: block [
	onLoginSuccess := block
]
