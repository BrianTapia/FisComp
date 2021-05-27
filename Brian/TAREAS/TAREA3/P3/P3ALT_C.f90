PROGRAM difusion1d
	IMPLICIT none
	INTEGER::Nx, Nt, i, j, t
	REAL(8)::C, s, a
	REAL(8)::tj, xi, dx, dt, L, tf
	REAL(8)::x0, xL
	REAL(8)::Di

	REAL(8),ALLOCATABLE::u(:)
	REAL(8)::u1, u2   ! Auxiliares en el cálculo de u(i).

	!READ(5, *)Nx, Nt, L, tf, C, s
	Nx = 400
	Nt = 80000
	L  = 4.d0
	tf = 20.d0
	C  = 1.d0
	s  = 0.5d0
	a  = 0.2d0

	x0 = 0
	xL = 0

	dx =  L/(Nx-1)
	dt = tf/(Nt-1)

	ALLOCATE(u(0: Nx))
	open(unit = 1, file = 'EvTemporal_x1.dat', status = 'unknown')
	open(unit = 2, file = 'EvTemporal_x2.dat', status = 'unknown')

 ! *****************************************************************************
 ! En t = 0
 u(1)  = x0
 u(Nx) = xL

	do i = 2, Nx-1
		xi   = (i-1)*dx
		u(i) = C*exp((-(xi - L/2.d0)**2)/(s**2))

		if(i.eq.100) write(1, *)0.d0, u(i);
		if(i.eq.200) write(2, *)0.d0, u(i);
	end do
	!*****************************************************************************
	! Iterando sobre t (ignoramos t = 0):
	do j = 2, Nt
		tj = (j-1)*dt

		do i = 2, Nx-1
			xi = (i-1)*dx
			Di = a*exp(-4.d0*xi/L) ! Enunciamos D(x) en el nodo i.

			! Antes de sobreescribir u(i), este término corresponde a
			! u(i) en el nodo temporal anterior (u_{i,j-1}).
			u1 = (dt/(dx**2.d0))*(u(i+1) - 2.d0*u(i) + u(i-1))
			u2 = (4.d0/L)*(dt/dx)*(u(i+1) - u(i))

			u(i) = u(i) + Di*(u1 - u2)

			if(i.eq.100) write(1, *)tj, u(i);
			if(i.eq.200) write(2, *)tj, u(i);
		end do
	end do

END PROGRAM difusion1d
