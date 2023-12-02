CREATE MAX-RED		0 ,
CREATE MAX-GREEN	0 ,
CREATE MAX-BLUE		0 ,

: COLOUR, ( " name" " max-var" -- )
	CREATE ,
DOES> ( removed -- )
	@ TUCK  @ MAX  SWAP ! ;

: COLOUR ( " name" " comma-variant" -- )
	CREATE ' ,
DOES> ( total removed -- total )
	@ EXECUTE ( total )
	MAX-RED @  MAX-GREEN @  *  MAX-BLUE @  *  +
	0 MAX-RED !  0 MAX-GREEN !  0 MAX-BLUE ! ;

MAX-RED		COLOUR,	red,
MAX-GREEN	COLOUR,	green,
MAX-BLUE	COLOUR,	blue,
COLOUR	red	red,
COLOUR	green	green,
COLOUR	blue	blue,

: red; red, ;
: green; green, ;
: blue; blue, ;

: Game ( " ...:" -- )
	[CHAR] : PARSE 2DROP ;

: AOC23-2-2 ( -- answer )
	0  S" 2.dat" INCLUDED ;

AOC23-2-2 . CR
