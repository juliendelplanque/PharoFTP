Extension { #name : #DateAndTime }

{ #category : #'*FTP' }
DateAndTime >> asFtpTimeStamp [
	^ String streamContents: [ :stream |
		self dayMonthYearDo: [ :day :month :year |
			stream nextPutAll: (year asString padded: #left to: 4 with: $0).
			stream nextPutAll: (month asString padded: #left to: 2 with: $0).
			stream nextPutAll: (day asString padded: #left to: 2 with: $0) ].
		stream nextPutAll: (self hours asString padded: #left to: 2 with: $0).
		stream nextPutAll: (self minutes asString padded: #left to: 2 with: $0).
		stream nextPutAll: (self seconds asString padded: #left to: 2 with: $0).
		self nanoSecond isZero ifFalse: [ 
			stream nextPut: $.; nextPutAll: (self nanoSecond asString padded: #left to: 3 with: $0) ] ].
]
