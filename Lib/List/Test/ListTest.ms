clearListener()

filein ( getFilenamePath(getSourceFileName()) + "/../List.ms" );



/* create a list */ 
List = List_v()

/* Add value */ 
List.setVal "first"  "Value A"

List.setVal "second" "Value B"
List.setVal "third"  undefined
List.setVal "fourth" "D"
List.setVal "fifth"  "E"

format "List             = % \n\n" List

/* Delete value */
List.delete "fifth"
format "delete fifth     = % \n" List;


/* Filter value */
List.filter undefined test:false       -- Filter items which ARE NOT undefined
format "filter undefined = % \n" List 

List.filter "Value*"                   -- Filter only values matching "Value*"
format "filter A         = % \n" List


/* Get value */
second = List.getVal "second"                   
format "get second item  = % \n" second