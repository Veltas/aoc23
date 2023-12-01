DECIMAL

: -ROT ( x1 x2 x3 -- x3 x1 x2 )
	ROT ROT ;

: 0>= ( n -- n>=0? )
	0< 0= ;

: ," ( " ...<quote>" -- )
	[CHAR] " PARSE  5 MIN  DUP C,  HERE  5 ALLOT  SWAP MOVE ;

CREATE DIGIT-STRINGS
	," one"
	," two"
	," three"
	," four"
	," five"
	," six"
	," seven"
	," eight"
	," nine"

: DIGIT>STR ( digit -- str n )
	1-  6 *  DIGIT-STRINGS +  COUNT ;

: >DIGIT ( char -- digit | -1 )
	[CHAR] 0 -  DUP 10 0 WITHIN IF DROP -1 THEN ;

: PREFIX? ( str prefix prefix-n -- prefix? )
	TUCK COMPARE 0= ;

: DIGIT-PREFIX ( str -- digit | -1 )
	10 1 DO
		DUP  I DIGIT>STR  PREFIX?  IF
			DROP I UNLOOP EXIT
		THEN
	LOOP DROP -1 ;

: NEW-DIGIT ( first|-1 last|-1 new-digit -- first' last' )
	NIP  OVER 0< IF  NIP DUP  THEN ;

: FOR-STRING ( str n -- str+n str )
	OVER +  SWAP ;

: FIRST&LAST ( str n -- first-digit last-digit )
	-1 -1  2SWAP FOR-STRING ?DO ( first last )
		I C@  >DIGIT DUP 0>= IF  NEW-DIGIT
		ELSE  DROP  I DIGIT-PREFIX DUP 0>= IF  NEW-DIGIT
		ELSE  DROP  THEN THEN
	LOOP
	OVER -1 = ABORT" Invalid input" ;

: LINE-VALUE ( str n -- val )
	FIRST&LAST  SWAP 10 *  + ;

: READ ( fam buf n -- read-n|-1 )
	ROT READ-LINE ABORT" Failed to read" ( read-n not-eof? )
	0= IF DROP -1 THEN ;

: TOTAL ( fam -- total )
	0 ( fam total )
	BEGIN
		PAD 80 ERASE
		OVER PAD 80 READ  DUP 0>= WHILE ( fam total read-n )
		PAD SWAP LINE-VALUE  +
	REPEAT DROP NIP ;

: OPEN ( path path-n -- fam )
	R/O OPEN-FILE ABORT" Failed to open" ;

: CLOSE ( fam -- )
	CLOSE-FILE ABORT" Failed to close file" ;

: AOC23-1-2 ( -- answer )
	S" 1.dat" OPEN  DUP TOTAL  SWAP CLOSE ;

AOC23-1-2 . CR
