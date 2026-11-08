DECLARE SUB SelectionSort ()
DEFINT A-Z

DECLARE FUNCTION RandInt% (lower, Upper)

DECLARE SUB CheckScreen ()
DECLARE SUB BubbleSort ()
DECLARE SUB Initialize ()
DECLARE SUB PrintOneBar (Row)
DECLARE SUB Reinitialize ()
DECLARE SUB SwapBars (Row1, Row2)


  TYPE SortType
     Length AS INTEGER
			       
     ColorVal AS INTEGER
     BarString AS STRING * 43
  END TYPE


  CONST FALSE = 0, TRUE = NOT FALSE, LEFTCOLUMN = 49
  CONST NUMOPTIONS = 11, NUMSORTS = 6

  DIM SHARED SortArray(1 TO 43) AS SortType, SortBackup(1 TO 43) AS SortType
  DIM SHARED OptionTitle(1 TO NUMOPTIONS) AS STRING * 12
  DIM SHARED StartTime AS SINGLE
  DIM SHARED Foreground, Background, NoSound, Pause
  DIM SHARED Selection, MaxRow, InitRow, MaxColors

  DATA  Bubble

  Initialize
  SelectionSort

  WHILE INKEY$ = ""
  WEND
  
  WIDTH 80, InitRow
  COLOR 7, 0
  CLS
  END

GetRow:
   IF InitRow = 50 THEN
      InitRow = 43
      RESUME
   ELSE
      InitRow = 25
      RESUME NEXT
   END IF

MonoTrap:
   MaxColors = 2
   RESUME NEXT

RowTrap:
   MaxRow = 25
   RESUME

SUB CheckScreen
   InitRow = 50
   ON ERROR GOTO GetRow
   LOCATE InitRow, 1

   MaxColors = 15
   ON ERROR GOTO MonoTrap
   SCREEN 1
   SCREEN 0

   MaxRow = 43
   ON ERROR GOTO RowTrap
   WIDTH 80, MaxRow
   ON ERROR GOTO 0
END SUB

SUB Initialize STATIC
   DIM TempArray(1 TO 43)
   
   CheckScreen

   FOR I = 1 TO MaxRow
      TempArray(I) = I
   NEXT I

   MaxIndex = MaxRow

   RANDOMIZE TIMER
   FOR I = 1 TO MaxRow

      ' Call RandInt% to find a random element in TempArray between 1
      ' and MaxIndex, then assign the value in that element to BarLength:
      Index = RandInt%(1, MaxIndex)
      BarLength = TempArray(Index)

      ' Overwrite the value in TempArray(Index) with the value in
      ' TempArray(MaxIndex) so the value in TempArray(Index) is
      ' chosen only once:
      TempArray(Index) = TempArray(MaxIndex)

      ' Decrease the value of MaxIndex so that TempArray(MaxIndex) can't
      ' be chosen on the next pass through the loop:
      MaxIndex = MaxIndex - 1

      ' Assign the BarLength value to the .Length element, then store
      ' a string of BarLength block characters (ASCII 223: ß) in the
      ' .BarString element:
      SortBackup(I).Length = BarLength
      SortBackup(I).BarString = STRING$(BarLength, 223)

      ' Store the appropriate color value in the .ColorVal element:
      IF MaxColors > 2 THEN
	 SortBackup(I).ColorVal = (BarLength MOD MaxColors) + 1
      ELSE
	 SortBackup(I).ColorVal = MaxColors
      END IF
   NEXT I

   CLS
   Reinitialize         ' Assign values in SortBackup to SortArray and draw
			' unsorted bars on the screen.
   NoSound = FALSE
   Pause = 2            ' Initialize Pause to 2 clock ticks (@ 1/9 second).
  
END SUB

SUB PrintOneBar (Row) STATIC
	LOCATE Row, 1
	COLOR SortArray(Row).ColorVal
	PRINT SortArray(Row).BarString;
END SUB

FUNCTION RandInt% (lower, Upper) STATIC
	RandInt% = INT(RND * (Upper - lower + 1)) + lower
END FUNCTION

SUB Reinitialize STATIC
   FOR I = 1 TO MaxRow
      SortArray(I) = SortBackup(I)
   NEXT I

   FOR I = 1 TO MaxRow
      LOCATE I, 1
      COLOR SortArray(I).ColorVal
      PRINT SortArray(I).BarString;
   NEXT I

   COLOR MaxColors, 0
END SUB

SUB SelectionSort STATIC
	Limit = MaxRow

	FOR I = 1 TO (Limit)
	  Min = I
	  FOR J = I + 1 TO (Limit)
	   IF SortArray(J).Length < SortArray(Min).Length THEN
	    Min = J
	   END IF
	  NEXT J
	   SWAP SortArray(I), SortArray(Min)
	   SwapBars I, Min
	 NEXT I
END SUB

SUB SwapBars (Row1, Row2) STATIC
	PrintOneBar Row1
	PrintOneBar Row2
END SUB

