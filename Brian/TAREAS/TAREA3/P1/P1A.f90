MODULE ctes
	IMPLICIT none
	REAL(8),PARAMETER::e0 = 8.8541878d-16  ! C²/(N*cm²)
	REAL(8),PARAMETER::PI = 3.1415926d0
	REAL(8),PARAMETER::e04PI = 1.d0/(4.d0*PI*e0)
END MODULE ctes

PROGRAM P1A
	use ctes
	IMPLICIT none
	INTEGER::N, i, j
	INTEGER::Nx, Ny
	REAL(8),ALLOCATABLE::Q(:), X(:), Y(:)
	! Esto es un error, lo siento. X guarda la posición en y mostrada en el plot
	! y viceversa. (En el archivo .gnu grafico file 2:1, perdón por eso).
	REAL(8),PARAMETER::rmax = 40.d0
	REAL(8)::h, x0, y0
	REAL(8)::Ex, Ey, E, V

	! Abrir 'input.dat' para inciso B.
	! Abrir 'input2.dat' para inciso C.
	open(1, file = 'input2.dat')
	read(1, *)N
	ALLOCATE(Q(N), X(N), Y(N))

	do i = 1, N
		read(1, *)Q(i), X(i), Y(i)
	end do

	write(6, *)Q

	h  = 0.1d0
	Nx = rmax*2.d0/h; Ny = rmax*2.d0/h

	open(44, file = 'potencial.dat', status = 'unknown')
	open(55, file = 'efield.dat', status = 'unknown')

	do j = 1, Ny
		y0 = -rmax + (j-1)*h
		do i = 1, Nx
			x0 = -rmax + (i-1)*h
			call efield_and_pot(x0, y0, X, Y, Q, N, Ex, Ey, V)
			write(44, *)x0, y0, V

			E = SQRT(Ex**2.d0 + Ey**2.d0)
			write(55, *)x0, y0, Ex/E, Ey/E
		end do
		write(44, *)''
		write(55, *)''
	end do

	CLOSE(1)
	CLOSE(44)
	CLOSE(55)
END PROGRAM

SUBROUTINE efield_and_pot(x0, y0, X, Y, Q, N, Ex, Ey, V)
	! Calcula el campo eléctrico y potencial en un punto (x0, y0) arbitrario,
	! superponiendo los aportes individuales de cada una de las cargas.
	USE ctes
	IMPLICIT none

	! Inputs y Outputs
	INTEGER,INTENT(IN)::N
	REAL(8),DIMENSION(N),INTENT(IN)::X, Y, Q
	REAL(8),INTENT(IN)::x0, y0
	REAL(8),INTENT(OUT)::Ex, Ey, V

	! Auxiliares:
	INTEGER::i
	REAL(8)::xi, yi, r

	Ex = 0.d0
	Ey = 0.d0

	V  = 0.d0

	do i = 1, N
		xi = x0 - X(i)
		yi = y0 - Y(i)
		r  = (xi**2.d0 + yi**2.d0)**(0.5d0)

		! Escribimos la ecuación para el campo en el punto (x0, y0).
		Ex = Ex + e04PI*Q(i)*xi/(r**3.d0)
		Ey = Ey + e04PI*Q(i)*yi/(r**3.d0)

		V  = V  + e04PI*(Q(i)/r)

	end do
END SUBROUTINE efield_and_pot
