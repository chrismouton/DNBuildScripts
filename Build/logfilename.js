/*********************************************************
*  Utility script for PRS Build                    *
*                                                        *
*  Generates a log filename based on current date/time.  *
*  Writes filename to stdout.                            *
*                                                        *
*********************************************************/

function padWithZeros(value) {
	if (value < 10) {
		value = "0" + value;
	}
	
	return value;
}

function generateFilename() {
	var currentDate = new Date();

	var prefix = "build";
	var dash = "-";
	var dot = ".";
	var suffix = "log";

	var filename = prefix
		+ dot
		+ currentDate.getYear()
		+ padWithZeros(currentDate.getMonth() + 1)
		+ padWithZeros(currentDate.getDate())
		+ dash
		+ padWithZeros(currentDate.getHours())
		+ padWithZeros(currentDate.getMinutes())
		+ padWithZeros(currentDate.getSeconds())
		+ dot
		+ suffix;

	return filename;
}

WScript.Echo(generateFilename());
