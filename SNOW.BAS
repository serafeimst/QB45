SCREEN 7

FOR i = 0 TO 15
CIRCLE (160, 100), i + 5, i
NEXT i

COLOR 3
FOR i = 0 TO 15
PRINT
NEXT i
PRINT "             MERRY CHRISTMAS        "

OPTION BASE 0

DIM SNOWX%(50)
DIM SNOWY%(50)

RANDOMIZE TIMER

FOR i = 0 TO 49
	SNOWX%(i) = INT(RND * 320)
	SNOWY%(i) = INT(RND * 200)
	PSET (SNOWX%(i), SNOWY%(i)), 15
NEXT i

DO
	FOR i = 0 TO 49
		COL = POINT(SNOWX%(i), SNOWY%(i) + 1)
		IF COL = 0 THEN
			PSET (SNOWX%(i), SNOWY%(i)), 0
			SNOWY%(i) = SNOWY%(i) + 1
			IF SNOWY%(i) >= 200 THEN
				SNOWX%(i) = INT(RND * 320)
				SNOWY%(i) = 0
			END IF
			PSET (SNOWX%(i), SNOWY%(i)), 15
		ELSE
			SNOWX%(i) = INT(RND * 320)
			SNOWY%(i) = 0
			PSET (SNOWX%(i), SNOWY%(i)), 15
		END IF
	NEXT i
LOOP UNTIL INKEY$ <> ""
SCREEN 0

