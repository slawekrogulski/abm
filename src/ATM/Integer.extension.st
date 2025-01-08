Extension { #name : 'Integer' }

{ #category : '*ATM' }
Integer >> zeroPadded [ 
	^(self asString) padLeftTo: 2 with: $0
]
