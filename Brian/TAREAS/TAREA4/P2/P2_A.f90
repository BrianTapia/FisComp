PROGRAM PREGUNTA2A
	IMPLICIT NONE
	INTEGER,PARAMETER:: N=100000
	REAL(8):: x, r, lambda
	REAL(8):: dist(1:N), lambdas(1:2)
	INTEGER:: i, l, ISEED

	INTERFACE
     DOUBLE PRECISION FUNCTION ran2(idum)
       INTEGER(selected_int_kind(9)), INTENT(INOUT) :: idum
     END FUNCTION ran2
  END INTERFACE

	lambdas = (/ 0.1d0, 10.d0 /)
	ISEED=4444

	DO l=1,2
		lambda = lambdas(l)
		IF(lambda.eq.0.1d0)OPEN(44, file = 'l01.dat')
		IF(lambda.eq.10.d0)OPEN(44, file = 'l10.dat')

		DO i=1,N
			r =  ran2(ISEED)
			x = -lambda*(LOG(1-r))

			dist(i) = x
			write(44, *)i, r, x

		END DO
	END DO

	CLOSE(44)

END PROGRAM PREGUNTA2A
