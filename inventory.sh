#!/bin/bash

clear_all () {
	clear
	> products.txt
	read -p "--- List cleared. Enter to continue > " resume
}

while [[ true ]]; do
	clear
	
	# to do: should I use `sed` for updating products?
	cat <<- _EOF_
	Menu:
	a - Add product
	l - List products
	d - delete product
	ca - Clear all products
	default - quit

	_EOF_

	read -p "Enter command > " command 

	case "$command" in
		
	    a) clear
		   read -p "Enter product > " product

		   # append
	       echo $product >> products.txt
	       ;;

	    l) clear
		   cat products.txt
		   echo ""
		   echo "products in total: $(wc -l < products.txt)" 
		   read -p "--- Enter to continue > " resume
	       ;;

		d) clear
		   read -p "Enter product to delete > " to_delete
		   
		   # if file has a single line, the file needs to be cleared
		   if [[ $(wc -l < products.txt) -eq 1 ]]; then
			   clear_all

		   else
			   # filter all non matching lines, overwrite
		       grep -v "$to_delete" products.txt > temp && mv temp products.txt
			   read -p "--- Deletion succesful. Enter to continue > " resume
		   fi
		   ;;

	   ca) clear_all
		   ;;

	    *) echo "done"
	       break 
	       ;;
	esac

done