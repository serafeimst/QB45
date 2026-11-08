DECLARE SUB turn (degrees AS DOUBLE)
DECLARE SUB minus ()
DECLARE SUB plus ()
DECLARE SUB forward (length AS DOUBLE, COL AS INTEGER)
DECLARE SUB KOCH (DEPTH AS INTEGER)
DECLARE SUB F (DEPTH AS INTEGER)
DIM SHARED angle AS DOUBLE
DIM SHARED COL AS INTEGER
DIM SHARED SCALE AS DOUBLE

SCREEN 2
RANDOMIZE TIMER

angle = 0
COUNT = 0
WHILE INKEY$ = ""
  IF COUNT > 100 THEN
    CLS
    COUNT = 0
  ELSE
    COUNT = COUNT + 1
  END IF
  DEPTH = 3   ' maximum recursion depth
  STRIDE = 4  ' length per line; needs to be bigger than depth
  SCALE = (STRIDE - DEPTH) * STRIDE * (.2 + RND)
  X = -160 / SCALE + RND * 640
  Y = -120 / SCALE + RND * 200
  COL = 1 + INT(RND * 16)
  PSET (X, Y), COL
  KOCH (DEPTH)
  SLEEP 1
WEND

SCREEN 0

SUB F (DEPTH AS INTEGER)
  IF DEPTH = 0 THEN
    forward SCALE, COL
  ELSE
    F DEPTH - 1
    plus
    F DEPTH - 1
    minus
    minus
    F DEPTH - 1
    plus
    F DEPTH - 1
  END IF
END SUB

SUB forward (length AS DOUBLE, COL AS INTEGER)
  LINE -STEP(COS(angle) * length, SIN(angle) * length), COL
END SUB

SUB KOCH (DEPTH AS INTEGER)
  ' axiom of the Koch curve
  F DEPTH
  minus
  minus
  F DEPTH
  minus
  minus
  F DEPTH
END SUB

SUB minus
  turn 60
END SUB

SUB plus
  turn -60
END SUB

SUB turn (degrees AS DOUBLE)
  angle = angle + degrees * 3.14159265# / 180
END SUB

