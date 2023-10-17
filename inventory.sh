#!/bin/bash

clear_all () {
	> products.txt
	read -p "--- List cleared. Enter to continue > " resume
}

list_all() {
	cat products.txt
	echo ""
	echo "products in total: $(wc -l < products.txt)" 
}

while [[ true ]]; do
	clear

	cat <<- _EOF_
	Menu:
	a - Add product
	l - List products
	d - delete product
	u - update product
	s - search product
	ca - Clear all products
	default - quit

	_EOF_

	read -p "Enter command > " command 

	clear

	case "$command" in

		a)
			list_all
			echo ""

			product=

			while [[ -z "$product" ]] do

			read -p "Enter product > " product

			if [[ -z "$product" ]]; then
				echo "Empty product, try again."
				echo ""
			fi

			done

		   # append
		   echo $product >> products.txt
		   echo ""
		   read -p "--- Product added succesfully. Enter to continue > " resume
		   ;;

	   l)   list_all
		   read -p "--- Enter to continue > " resume
		   ;;

	   d)
		   list_all
		   while true; do

		   echo ""
		   read -p "Enter product to delete > " to_delete

		   if [[ -z $to_delete ]]; then
			   echo "Empty product. Try again."
		   	
		   elif grep -q "$to_delete" products.txt; then

			# if file has a single line, the file needs to be cleared
			if [[ $(wc -l < products.txt) -eq 1 ]]; then
				clear_all
				break

			else
				grep -v "$to_delete" products.txt > temp && mv temp products.txt
				read -p "--- Deletion successful. Enter to continue > " resume
				break
			fi
		else
			echo "Product not found."
		   fi

		done
		   ;;

	   u)
		   list_all
		   echo ""
		   read -p "Enter product name to update > " to_update
		   read -p "Enter updated name > " updated_name
		   sed -i "s/$to_update/$updated_name/" products.txt
		   read -p "--- Replacing succesful. Enter to continue > " resume
		   ;;
	
	   s)
		   list_all
		   while true; do
  
		   echo ""
		   read -p "Enter product name to search > " to_search

		   if [[ -z $to_search ]]; then
			   echo "Empty search. Enter product."
		   elif grep -q "$to_search" products.txt; then
			   echo "Product: $to_search"
			   echo "<attributes>"
			   echo ""
			   read -p "--- Enter to continue > " resume
			   break
		   else
			   echo "Product not found."
		   fi

	           done
	           ;;

	   ca) clear_all
		   ;;

	   *) echo "done"
		   break 
		   ;;
   esac

done
