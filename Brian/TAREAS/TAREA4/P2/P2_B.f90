PROGRAM PREGUNTA2B
	IMPLICIT NONE
	INTEGER,PARAMETER:: N=100000
	REAL(8):: x, r
	REAL(8):: dist(1:N)
	INTEGER:: i, ISEED

	INTERFACE
     DOUBLE PRECISION FUNCTION ran2(idum)
       INTEGER(selected_int_kind(9)), INTENT(INOUT) :: idum
     END FUNCTION ran2
  END INTERFACE

	ISEED=4444
	OPEN(44, file = 'sin.dat')

	DO i=1,N
		r = ran2(ISEED)
		x = ACOS(1-r)

		dist(i) = x
		write(44, *)i, r, x
	END DO

END PROGRAM PREGUNTA2B
