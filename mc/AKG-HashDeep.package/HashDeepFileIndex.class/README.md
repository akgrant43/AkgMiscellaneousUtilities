Index the supplied HashDeepFiles and provide convenience methods.

To find out which files exist only in leftSide:

| dir leftSide domcich1 domcich1Filenames |

dir := '/home/alistair/Documents/2017/1711Nov/hashdeep' asFileReference.
leftSide := HashDeepFiles fromFileName: (dir resolveString: 'domcich1/zdata03-backups-xps13-1703xx.hash').
domcich1Filenames := #('zdata03-backups-alistair-xps13.hash')
	collect: [ :fn | dir resolveString: 'domcich1/', fn ].
domcich1 := HashDeepFileIndex new.
domcich1Filenames do: [ :fn | domcich1 add: (HashDeepFiles fromFileName: fn) ].
{
	leftSide.
	domcich1. 
	domcich1 filesOnlyIn: leftSide.
}



 
Internal Representation and Key Implementation Points.

    Instance Variables
	collections:		<Object>
	fileDictionary:		<Object>


    Implementation Points