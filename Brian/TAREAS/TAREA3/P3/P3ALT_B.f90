PROGRAM difusion1d
	IMPLICIT none
	INTEGER::Nx, Nt, i, j, t
	REAL(8)::C, s, a
	REAL(8)::tj, xi, dx, dt, L, tf(3)
	REAL(8)::x0, xL
	REAL(8)::Di

	REAL(8),ALLOCATABLE::u(:)
	REAL(8)::u1, u2   ! Auxiliares en el cálculo de u(i).

	!READ(5, *)Nx, Nt, L, tf, C, s
	Nx = 400
	Nt = 20000
	L  = 4.d0
	tf = (/0.05d0, 1.d0, 5.d0/)
	C  = 1.d0
	s  = 0.5d0
	a  = 0.2d0

	x0 = 0
	xL = 0

	dx =  L/(Nx-1)

	ALLOCATE(u(0: Nx))

 ! *****************************************************************************
 ! En t = 0
 u(1)  = x0
 u(Nx) = xL

	do i = 2, Nx-1
		xi   = (i-1)*dx
		u(i) = C*exp((-(xi - L/2.d0)**2)/(s**2))
	end do
	!*****************************************************************************
	do t = 1, 3
		dt = tf(t)/(Nt-1)
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
			end do
		end do

		! Aquí ya llegamos al tiempo final. Escribimos los datos pedidos:
		do i = 1, Nx
			xi = (i-1)*dx
			if(t.eq.1) write(44,*)xi, u(i);
			if(t.eq.2) write(55,*)xi, u(i);
			if(t.eq.3) write(66,*)xi, u(i);

		end do
	end do

END PROGRAM difusion1d
