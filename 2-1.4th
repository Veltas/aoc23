: COLOUR, ( " name" actual -- )
	CREATE ,
DOES> ( valid? removed -- valid'? )
	@ > IF  DROP FALSE  THEN ;

: COLOUR ( " name" " comma-variant" -- )
	CREATE ' ,
DOES> ( total num valid? removed -- total num+1 true )
	@ EXECUTE ( total num valid'? )
	IF  SWAP OVER + SWAP  THEN  1+  TRUE ;

12	COLOUR,	red,
13	COLOUR,	green,
14	COLOUR,	blue,
COLOUR	red	red,
COLOUR	green	green,
COLOUR	blue	blue,

: red; red, ;
: green; green, ;
: blue; blue, ;

: Game ( " ...:" -- )
	[CHAR] : PARSE 2DROP ;

: AOC23-2-1 ( -- answer )
	0 1 TRUE  S" 2.dat" INCLUDED  2DROP ;

AOC23-2-1 . CR
