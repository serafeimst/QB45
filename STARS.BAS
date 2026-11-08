DECLARE SUB InitPalette ()
DEFINT A-Z

DECLARE SUB InitNewParticles (x#(), y#(), z#(), dt#(), n)
DECLARE SUB NewParticle (x#, y#, z#, dt#)
DECLARE SUB DrawParticles (x#(), y#(), z#(), n)
DECLARE SUB UpdateParticles (x#(), y#(), z#(), dt#(), n)

DIM x#(256)
DIM y#(256)
DIM z#(256)
DIM dt#(256)

DIM SHARED depth#
depth# = 5!
n = 100
active = 1
visible = 0

RANDOMIZE TIMER
SCREEN 7

InitPalette
CALL InitNewParticles(x#(), y#(), z#(), dt#(), n%)

WHILE INKEY$ = ""
  CALL UpdateParticles(x#(), y#(), z#(), dt#(), n)
  CALL DrawParticles(x#(), y#(), z#(), n)
  SWAP active, visible
  SCREEN 7, , active, visible
  CLS 1
WEND
SCREEN 0
CLS
END

SUB DrawParticles (x#(), y#(), z#(), n)
  FOR I = 0 TO n - 1
    px = 160 + 10 * x#(I) / z#(I)
    py = 100 + 10 * y#(I) / z#(I)
    newCol = 15 - 15 * z#(I) / depth#
    oldCol = POINT(px, py)
    IF oldCol < newCol THEN
      PSET (px, py), newCol
    END IF
  NEXT I
END SUB

SUB InitNewParticles (x#(), y#(), z#(), dt#(), n%)
  FOR I = 0 TO n - 1
    CALL NewParticle(x#(I), y#(I), z#(I), dt#(I))
    z#(I) = depth# * RND
  NEXT I
END SUB

SUB InitPalette
  FOR I = 1 TO 15
    OUT &H3C8, I
    OUT &H3C9, (I + 1) * 4 - 1
    OUT &H3C9, (I + 1) * 4 - 1
    OUT &H3C9, (I + 1) * 4 - 1
    PALETTE I, I
  NEXT I
END SUB

SUB NewParticle (x#, y#, z#, dt#)
  x# = -50 + 100 * RND
  y# = -50 + 100 * RND
  z# = depth#
  dt# = .01 + .1 * RND
END SUB

SUB UpdateParticles (x#(), y#(), z#(), dt#(), n)
  FOR I = 0 TO n - 1
    ' move stars and create new ones
    z#(I) = z#(I) - dt#(I)
    IF z#(I) <= 0! THEN
      CALL NewParticle(x#(I), y#(I), z#(I), dt#(I))
    END IF
  NEXT I
END SUB

