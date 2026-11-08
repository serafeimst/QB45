SCREEN 0
DIM VERT%(120)
KEY OFF
CLS

Start:
INPUT "Enter screen mode"; SCR
INPUT "Enter radius (range 10-170)"; R
INPUT "Enter number of vertices (range 3-50)"; V

SCREEN SCR
CLS

X0 = 360 + R * 1.5: Y0 = 170
PSET (X0, Y0)
THETA = 6.28319 / V: N = V - 1

FOR I = 1 TO N
        VERT%(2 * I - 1) = R * 1.5 * COS(THETA * I) + 360
        VERT%(2 * I) = R * SIN(THETA * I) + 170
        PSET (VERT%(2 * I - 1), VERT%(2 * I)), 1
NEXT I

N0 = N
FOR J = 1 TO N
        FOR I = 1 TO N0
                XN = VERT%(2 * I - 1): YN = VERT%(2 * I)
                LINE (X0, Y0)-(XN, YN)
        NEXT I
X0 = XN: Y0 = YN: N0 = N0 - 1
NEXT J
LOCATE 1, 1
INPUT "Try another (Y/N)"; A$
IF A$ = "Y" OR A$ = "y" GOTO Start
CLS
END