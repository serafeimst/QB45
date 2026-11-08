TYPE Vertex
    x AS SINGLE
    y AS SINGLE
    z AS SINGLE
END TYPE

DIM angle AS DOUBLE
active = 1
visible = 0
DIM vs(0 TO 7) AS Vertex

vs(0).x = .25:   vs(0).y = .25:   vs(0).z = .25
vs(1).x = -.25: vs(1).y = .25:    vs(1).z = .25
vs(2).x = -.25: vs(2).y = -.25: vs(2).z = .25
vs(3).x = .25:   vs(3).y = -.25: vs(3).z = .25

vs(4).x = .25:   vs(4).y = .25:   vs(4).z = -.25
vs(5).x = -.25: vs(5).y = .25:    vs(5).z = -.25
vs(6).x = -.25: vs(6).y = -.25: vs(6).z = -.25
vs(7).x = .25:   vs(7).y = -.25: vs(7).z = -.25

DIM fs(0 TO 5, 0 TO 3) AS INTEGER

fs(0, 0) = 0
fs(0, 1) = 1
fs(0, 2) = 2
fs(0, 3) = 3

fs(1, 0) = 4
fs(1, 1) = 5
fs(1, 2) = 6
fs(1, 3) = 7

fs(2, 0) = 0
fs(2, 1) = 4

fs(3, 0) = 1
fs(3, 1) = 5

fs(4, 0) = 2
fs(4, 1) = 6

fs(5, 0) = 3
fs(5, 1) = 7

angle = 0
CLS

WHILE INKEY$ = ""

    SCREEN 7, , active, visible
    CLS 1

    FOR face = 0 TO 5

        IF face < 2 THEN
            n = 4
        ELSE
            n = 2
        END IF

        FOR i = 0 TO n - 1

            aIndex = fs(face, i)
            bIndex = fs(face, (i + 1) MOD n)

            ax = vs(aIndex).x
            ay = vs(aIndex).y
            az = vs(aIndex).z

            bx = vs(bIndex).x
            by = vs(bIndex).y
            bz = vs(bIndex).z

            '-----------------------
            ' Rotate XZ
            '-----------------------

            c = COS(angle)
            s = SIN(angle)

            xa = ax * c - az * s
            za = ax * s + az * c

            xb = bx * c - bz * s
            zb = bx * s + bz * c

            '-----------------------
            ' Translate Z
            '-----------------------

            za = za + 1
            zb = zb + 1

            '-----------------------
            ' Project
            '-----------------------

            p1x = xa / za
            p1y = ay / za

            p2x = xb / zb
            p2y = by / zb

            '-----------------------
            ' Screen
            '-----------------------

            s1x = (p1x + 1) / 2 * 320
            s1y = (1 - (p1y + 1) / 2) * 200

            s2x = (p2x + 1) / 2 * 320
            s2y = (1 - (p2y + 1) / 2) * 200

            '-----------------------
            ' Draw
            '-----------------------

            LINE (s1x, s1y)-(s2x, s2y)

        NEXT i

    NEXT face

    angle = angle + .01

    SWAP active, visible
WEND

CLS
SCREEN 0

