DECIMAL

: CRUCIAL ( " aborting-word" " error-flags-word" -- )
	CREATE  ' ,
DOES>
	@ EXECUTE  ABORT" Failed!" ;

CRUCIAL	OPEN-FILE!	OPEN-FILE
CRUCIAL	READ-LINE!	READ-LINE
CRUCIAL	CLOSE-FILE!	CLOSE-FILE

: >DIGIT ( c -- digit|-1 )
	[CHAR] 0 - ( digit )
	DUP 10 0 WITHIN IF DROP -1 THEN ;

: STR>NUM ( str u -- n )
	-1 -1 2SWAP  OVER + SWAP ?DO ( first last )
		I C@ >DIGIT DUP 0< 0= IF ( first last current )
			NIP ( first last' )
			OVER 0< IF NIP DUP THEN ( first' last' )
		ELSE DROP THEN
	LOOP
	DUP 0< ABORT" Invalid input"
	SWAP 10 *  + ;

: NUM ( fam -- n|-1 )
	PAD 80 ROT READ-LINE!  ( n-chars-read not-eof? )
	IF  PAD SWAP STR>NUM  ELSE  -1  THEN ;

: TOTAL ( fam -- total )
	0 SWAP  ( total fam )
	BEGIN  DUP NUM  DUP 0< 0= WHILE  ( total fam n )
		ROT + SWAP
	REPEAT 2DROP ;

: AOC23-1-1 ( -- total )
	S" 1.dat" R/O OPEN-FILE!  DUP TOTAL  CLOSE-FILE! ;

AOC23-1-1 . CR
