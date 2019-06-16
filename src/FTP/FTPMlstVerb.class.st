"
The MLST and MLSD commands are intended to standardize the file and directory information returned by the Server-FTP process.  These commands differ from the LIST command in that the format of the replies is strictly defined although extensible.

Two commands are defined, MLST which provides data about exactly the object named on its command line, and no others. MLSD on the other hand will list the contents of a directory if a directory is named, otherwise a 501 reply will be returned. In either case, if no object is named, the current directory is assumed. That will cause MLST to send a one line response, describing the current directory itself, and MLSD to list the contents of the current directory.
"
Class {
	#name : #FTPMlstVerb,
	#superclass : #FTPModernListing,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPMlstVerb class >> verbs [
	^ Array with: 'MLST'.
]

{ #category : #accessing }
FTPMlstVerb >> children [
	^ Array with: (self findContext: self request argument).
]

{ #category : #processing }
FTPMlstVerb >> execute [
	self return: (FTPResponse code: 250 string: (String streamContents: [ :stream |
		self print: self children on: stream.
		stream skip: String crlf size negated ])).
]
