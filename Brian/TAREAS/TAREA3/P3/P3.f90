PROGRAM P3A
	IMPLICIT none
	! Declaración de variables:
	REAL(8)::L , tf
	INTEGER::Nx, Nt
	REAL(8)::h , a, C
	REAL(8)::x0, xL
	REAL(8),PARAMETER::s = 0.5d0
	INTEGER::i, j

	REAL(8),ALLOCATABLE::u(:, :), D(:)

	! Datos del problema:
	write(6, *)'Largo L del alambre: '
	read(5,*)L

	write(6, *)'Tiempo final: '
	read(5, *)tf

	if(L.le.tf)then
		write(6, *)'Número de puntos para grilla en x: '
		read(5, *)Nx
		h = L/Nx; Nt = int(tf/h)
	else
		write(6, *)'Número de puntos para grilla en t: '
		read(5, *)Nt
		h = tf/Nt; Nx = int(L/h)
		write(6,*)tf, Nt, h
	endif

	!Condiciones de frontera (x):
	x0 = 1
	xL = 3

	write(6, *)'Parámetro ª: '
	read(5, *)a
	write(6, *)'Parámetro C: '
	read(5, *)C

	! Localiza la memoria para las funciones u(x, t) y D(x):
	ALLOCATE(u(0: Nx, 0: Nt), D(0: Nx))

	! Inicializa la red:
	call red_inicial(C, L, s, x0, xL, h, Nx, Nt, u, D)

	do i = 1, Nx
		write(66,*) u(i, :)
	enddo

END PROGRAM P3A

!*******************************************************************************

SUBROUTINE red_inicial(C, L, s, x0, xL, h, Nx, Nt, u, D)
	IMPLICIT none
	INTEGER,INTENT(IN)::Nx, Nt
	REAL(8),INTENT(IN)::x0, xL, h, C, L, s
	REAL(8),DIMENSION(0: Nx, 0: Nt),INTENT(INOUT)::u
	REAL(8),DIMENSION(0: Nx)       ,INTENT(INOUT)::D

	INTEGER::i, j
	REAL(8)::xi

	! Se inicializan como 0:
	u = 0.d0; D = 0.d0

	! Condiciones de frontera en x:
	u(:, 0)  = x0
	u(:, Nt-1) = xL

	! Condiciones dadas por u(x, 0):
	do j = 1, Nt-1
		xi = j*h
		u(0, :) = 2
		write(6,*)j
		!u(0, :) = C*exp((-(xi - L/2.d0)**2)/(s**2))
	enddo

END SUBROUTINE red_inicial

!*******************************************************************************
