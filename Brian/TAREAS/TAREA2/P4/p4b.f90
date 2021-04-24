PROGRAM p4b
	implicit none
	integer::i,N
	real(8)::k1,k2,k3,k4
	real(8)::x0,fx0
	real(8)::x,fx,freal,relerr
	real(8)::a,b,h
	
	! Condiciones iniciales:
	x0 = 0.d0
	fx0 = 1.d0
	
	! Pasos e intervalo de solución:
	a = 0.d0; b = 4.d0
	h = 0.01d0; N = (b-a)/h
	
	do i=1,N
		x = x0+h
		
		call ode(x0           , fx0              , k1)
		call ode(x0+((h/2.d0)), fx0+((h/2.d0)*k1), k2)
		call ode(x0+((h/2.d0)), fx0+((h/2.d0)*k2), k3)
		call ode(x0+(h)       , fx0+(h*k3)       , k4)
		
		fx = fx0 + (h/6.d0)*(k1+2.d0*k2+2.d0*k3+k4)
		
		x0 = x
		fx0 = fx
		
		freal = exp(-(x**2)/2)
		
		relerr = abs((fx - freal)/freal)
		
		write(67,*)x, fx, freal, relerr
	end do
	
END PROGRAM p4b

SUBROUTINE ode(x, fx, valor)
	implicit none
	real(8),INTENT(IN)::x,fx
	real(8),INTENT(OUT)::valor

	valor = -x*fx
	
END SUBROUTINE ode
