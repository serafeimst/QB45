DECLARE SUB InitRocket (x0#(), y0#(), vx0#(), vy0#())
DECLARE SUB UpdateParticles (x#(), y#(), x0#(), y0#(), vx0#(), vy0#(), t#, n%)
DECLARE SUB DrawParticles (x#(), y#(), n%, col%)
DECLARE SUB InitExplosion (x#(), y#(), x0#(), y0#(), vx0#(), vy0#(), n%)

DEFINT A-Z

DIM x#(256)
DIM y#(256)
DIM x0#(256)
DIM y0#(256)
DIM vx0#(256)
DIM vy0#(256)

active = 1
visible = 0
frame = 1
n = 1
isExploded = 0
t# = 1!
dt# = .5
g# = .00981

RANDOMIZE TIMER
CALL InitRocket(x0#(), y0#(), vx0#(), vy0#())

SCREEN 7, , active, visible

WHILE INKEY$ = ""
  CALL UpdateParticles(x#(), y#(), x0#(), y0#(), vx0#(), vy0#(), t#, n)
  CALL DrawParticles(x#(), y#(), n, (frame MOD 15) + 1)
  IF frame MOD 170 = 0 THEN
    t# = 0!
    IF isExploded = 1 THEN
      isExploded = 0
      n = 1
      CALL InitRocket(x0#(), y0#(), vx0#(), vy0#())
    ELSE
      isExploded = 1
      n = 100
      CALL InitExplosion(x#(), y#(), x0#(), y0#(), vx0#(), vy0#(), n)
    END IF
  ELSE
    t# = t# + dt#
  END IF
  frame = frame + 1
  SWAP active, visible
  SCREEN 7, , active, visible
  CLS 1
WEND
CLS
SCREEN 0

SUB DrawParticles (x#(), y#(), n, col)
  FOR I = 0 TO n - 1
    PSET (x#(I), 199 - y#(I)), col
  NEXT I
END SUB

SUB InitExplosion (x#(), y#(), x0#(), y0#(), vx0#(), vy0#(), n)
  x1# = x#(0)
  y1# = y#(0)
  FOR I = 0 TO n - 1
    v0# = 1.5 * RND + .5
    theta# = 6.283185 * RND
    x0#(I) = x1#
    y0#(I) = y1#
    vx0#(I) = v0# * COS(theta#)
    vy0#(I) = v0# * SIN(theta#)
  NEXT I
END SUB

SUB InitRocket (x0#(), y0#(), vx0#(), vy0#())
  x0#(0) = 120! + 80! * RND
  y0#(0) = 0
  vx0#(0) = 2! * RND - 1!
  vy0#(0) = 2! * RND + 1!
END SUB

SUB UpdateParticles (x#(), y#(), x0#(), y0#(), vx0#(), vy0#(), t#, n)
  SHARED g#
  FOR I = 0 TO n - 1
    x#(I) = x0#(I) + vx0#(I) * t#
    y#(I) = y0#(I) + vy0#(I) * t# - .5 * g# * t# * t#
  NEXT I
END SUB

