"
Journal Presenter
"
Class {
	#name : 'JournalPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'journalEntries'
	],
	#category : 'ATM-ui',
	#package : 'ATM',
	#tag : 'ui'
}

{ #category : 'layout' }
JournalPresenter >> defaultLayout [ 
^SpBoxLayout newTopToBottom 
	spacing: 5;
	add: journalEntries expand: true fill: true;
	yourself.
]

{ #category : 'initialization' }
JournalPresenter >> initializePresenters [
	|right center|
	right := [:je | SpColumnAlignment right].
	center := [:je | SpColumnAlignment center ].
	journalEntries := self newTable 
		propagateNaturalWidth: true ;
		propagateNaturalHeight: true .
	{
	SpStringTableColumn new title: 'Id'        ; evaluated: #id; displayAlignment: right; width: 20.
	"SpStringTableColumn new title: 'Name'     ; evaluated: [ :je | je name ]."
	SpStringTableColumn new title: 'Date'      ; evaluated: #date; displayAlignment: right; width: 80.
	SpStringTableColumn new title: 'Time'      ; evaluated: #time; width: 80.
	SpStringTableColumn new title: 'Dr Account'; evaluated: [ :je | je drAccount name ] .
	SpStringTableColumn new title: 'Cr Account'; evaluated: [ :je | je crAccount name ] .
	"SpStringTableColumn new title: 'Operation'; evaluated: #transactionType ."
	SpStringTableColumn new title: 'Amount'    ; evaluated: #amount; displayAlignment: right; width: 100.
	SpStringTableColumn new title: 'Posted'    ; evaluated: #posted; displayAlignment: center; width: 70
	} do: [ :column | journalEntries addColumn: column ].
]

{ #category : 'initialization' }
JournalPresenter >> initializeWindow: aWindowPresenter [
	|refreshButton postButton resetButton toolbar|
"	aWindowPresenter whenClosedDo: [ 
		application class removePresenterToUpdateFor: application loggedInUser ]."
	postButton := self newToolbarButton 
		label: 'Post';
		action: [ self post ];
		icon: (self iconNamed: #scriptManager ) ;
		yourself.
	refreshButton := self newToolbarButton 
		label: 'Refresh';
		action: [ self updatePresenter ];
		icon: (self iconNamed: #glamorousRefresh );
		yourself.
	resetButton := self newToolbarButton 
		label: 'Reset';
		action: [ self reset ];
		icon: (self iconNamed: #remove);
		yourself.
	toolbar := self newToolbar 
		add: postButton ;
		add: refreshButton ;
		add: resetButton ;
		addStyle: 'toolbarButtonLabelStyle';
		yourself.
	aWindowPresenter 
		title: 'Journal';
		toolbar: toolbar;
		statusBar: (self newLabel label: 'status');
		initialExtent: 800@400 .

]

{ #category : 'account ops' }
JournalPresenter >> post [ 
	application post.
]

{ #category : 'initialization' }
JournalPresenter >> reset [ 
	|presenter windowPresenter|
	presenter := application newPresenter:JournalResetPresenter .
	windowPresenter := presenter openModal .
	windowPresenter isOk ifFalse: [ ^ self ].
	Journal initialize .
	self updatePresenter .
]

{ #category : 'initialization' }
JournalPresenter >> updatePresenter [ 
	super updatePresenter .
	"Transcript show: ('{1}.updatePresenter for {2}' format: {self class name . application loggedInUser }); cr."
	journalEntries items: (Journal list)
]
