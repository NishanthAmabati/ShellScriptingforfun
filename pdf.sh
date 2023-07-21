# I have created a custom shell script that offers a convenient way to open PDF files in either Google Chrome or the default GNOME PDF 
# viewer directly from the terminal. This script eliminates the need to open PDFs manually using the mouse, providing a more efficient and seamless experience.

# When executed in the terminal, the script prompts the user to select their preferred option for viewing the PDF. You can choose 
# between opening the PDF in the Google Chrome browser or the GNOME default PDF viewer (Evince). This flexibility allows users to 
# tailor their PDF viewing experience according to their preferences and needs.

# By utilizing this custom shell script, users can effortlessly access PDF files without the hassle of navigating through their file 
# manager or launching the respective applications separately. This streamlined approach enhances productivity, especially for
# individuals who frequently work with PDF documents and prefer a terminal-based workflow.

# # version : 1.0 | date : June 11th, 2023
#!/usr/bin/bash

#./pdf.sh <option> <file>

# check if the right amount of required parameters were given
if [ $# -eq 2 ]
then
	# REGEX if the flags entered are correct
	if [[ $1 =~ ^\-+[eg] && -f "$2" ]]
	then
		if [ $1 == "-g" ]
		then
			google-chrome $2 &
			exit 0
		elif [ $1 == "-e" ]
		then 
			evince $2 &
			exit 0
		fi
	elif [ $1 !=~ ^\-+[a-z] ]
	then
		echo -e "Please enter a valid option.\n-g : used google-chrome\n-e : used default document viewer"
		exit 1
	elif [ -f ! "$2" ]
	then 
		echo -e "<$2> file does not exit.\nPlease enter a valid file."
		exit 1
	else
		echo "Please provide valid option and file."
	fi
else
	echo -e "Please provide option and filename.\nsyntax : ./pdf.sh [option] <file>"
fi


