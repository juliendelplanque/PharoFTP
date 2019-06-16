Class {
	#name : #FTPTonelContext,
	#superclass : #FTPContext,
	#category : #'FTP-Tonel'
}

{ #category : #'accessing-strings' }
FTPTonelContext >> welcomeString [
	" Return a welcome string to be displayed when a new session is started. "

	^ 'PharoFTP ready'
]
