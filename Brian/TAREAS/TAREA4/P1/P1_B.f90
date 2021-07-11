PROGRAM PREGUNTA1
	IMPLICIT NONE
	INTEGER,PARAMETER:: N=100000, MINX=0, MAXX=1
	REAL(8):: val, integral, volumen, R_TEST
	REAL(8),ALLOCATABLE:: x(:, :)
	INTEGER:: i, j, M, ISEED

	INTERFACE
     DOUBLE PRECISION FUNCTION ran2(idum)
       INTEGER(selected_int_kind(9)), INTENT(INOUT) :: idum
     END FUNCTION ran2
  END INTERFACE

	ISEED=4444

	DO M=4, 12
		! Localiza la matriz que guarda los valores en cada punto aleatorio.
		ALLOCATE(x(0:M-1, 0:N-1))
		integral = 0
		DO j = 0, N-1
			R_TEST = 0

			! Agrega x1, x2, x3, ..., xM. Aleatorios por ran2.
			DO i = 0, M-1
				x(i, j) = ran2(ISEED)
				R_TEST = R_TEST + x(i, j)**2.d0
			END DO

			! Si no se cumple la condición de el punto estar dentro del
			! radio de la hiper-esfera, elimina los números aleatorios generados
			! y los reemplaza por ceros (básicamente, agrega ceros).
			IF(R_TEST.gt.M)THEN
				x(:, j) = 0
			END IF

			val = M
			DO i = 0, M-1
				val = val - x(i, j)**2.d0
			END DO
			val = val**(0.5d0)

			integral = integral + val
		END DO

		! Volumen para la región de integración (todas las dimensiones entre 0 y 1)
		volumen = (MAXX - MINX)**M
		! da 1 xd, pero en caso de generalizarse sirve.
		! (ej: x1, x2, x3, ..., xM van de 0 a 10; pero todos en el mismo intervalo).

		integral = integral/N
		integral = integral*volumen

		WRITE(6, *)'M: ', M, '|| Valor: ', integral

		DEALLOCATE(x)

	END DO

END PROGRAM PREGUNTA1
