filein ( getFilenamePath(getSourceFileName()) + "/../List.ms" );




-- create a list
	arr=List()
	
/* Add value */ 
	--arr.setVal #name "dave"
	arr.setVal "name" "dave"
	print "Added val";
	print ( (arr.getVal "name")=="dave" );

/* Delete value */
	print "Delete val";
	arr.delete "name"
	print ( (arr.getVal "name")==undefined );

	
--	arr.setVal #height 10
	

---- add a sub list
--	-- create the list
--		books=List()
--		books.setVal #shakespeare "much ado about nothing"
--		books.setVal #dickens "a christmas carol"
--	
--	-- add it to the original list
--		arr.setVal #books books
--		
--	-- retrieve the value
--		(arr.getVal #books).getVal #shakespeare



/*
		fn delete str=
		(
			local i=findItem names str
			if i>0 then 
			(
				local namesArr=deleteItem names i
				local valuesArr=deleteItem values i
			)
			return #(namesArr,valuesArr)
		)
*/
