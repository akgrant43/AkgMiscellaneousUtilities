SanoPlasmaScanResults interprets the data from a SanoPlasma scan csv file and presents it as: 

- a text report
- a graph

The text report can easily be converted to pdf with: 

enscript -B report.txt -o - | ps2pdf - out.pdf 


Public API and Key Messages

- on: aFileReference - open the supplied results file
- saveReportString - save the text report in the default location (SanoPlasma>>reportDirectory)
 

Internal Representation and Key Implementation Points.

 Instance Variables
	fileReference:		<FileReference> The SanoPlasma data file containing the scan results


    Implementation Points