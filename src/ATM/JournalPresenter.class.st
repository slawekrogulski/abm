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

{ #category : 'column creation' }
JournalPresenter >> column: title eval: evalBlock [
	^SpStringTableColumn new 
		title: title;
		evaluated: evalBlock.
]

{ #category : 'column creation' }
JournalPresenter >> column: title eval: evalBlock align: align [
	^(self column: title eval: evalBlock)
		displayAlignment: [SpColumnAlignment perform: align].
]

{ #category : 'column creation' }
JournalPresenter >> column: title eval: evalBlock align: align width: width [
	^(self column: title eval: evalBlock align: align) width: width.
"	^SpStringTableColumn new 
		title: title;
		evaluated: evalBlock;
		displayAlignment: [SpColumnAlignment perform: align] ;
		width: width."
]

{ #category : 'column creation' }
JournalPresenter >> column: title eval: evalBlock width: width [
	^SpStringTableColumn new 
		title: title;
		evaluated: evalBlock;
		width: width .
]

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
	right := [SpColumnAlignment right].
	center := [SpColumnAlignment center ].
	journalEntries := self newTable 
		propagateNaturalWidth: true ;
		propagateNaturalHeight: true .
	{
	self column: 'Id'         eval: #id                                                 align: #right  width: 20.
	self column: 'Date'       eval: #date                                               align: #right  width: 80.
	self column: 'Time'       eval: #time                                                              width: 80. 
	self column: 'Dr Account' eval: [ :je | je drAccount name ] .
	self column: 'Cr Account' eval: [ :je | je crAccount name ] .
	self column: 'Amount'     eval: [ :je | je amount asStringWithCommas ]              align: #right  width: 100. 
	self column: 'Posted'     eval: [ :je | je posted ifTrue: [ 'Y' ] ifFalse: [ 'N' ]] align: #center width: 70.
	self column: 'Notes'      eval: #note 
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
		initialExtent: 900@400 .

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
