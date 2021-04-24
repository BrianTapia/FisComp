PROGRAM p4b
	implicit none
	integer::i,N
	real(8)::kf1,kf2,kf3,kf4
	real(8)::kg1,kg2,kg3,kg4
	real(8)::x0,f0,g0
	real(8)::x,fx,gx,freal,relerr
	real(8)::a,b,h
	
	! Condiciones iniciales:
	x0 = 0.d0
	f0 = 1.d0
	g0 = 0.d0
	
	! Pasos e intervalo de solución:
	a = 0.d0; b = 4.d0
	h = 0.01d0; N = (b-a)/h
	
	do i=1,N
		x = x0+h
		
		call ode1(f0, g0, kg1)
		call ode2(g0, kf1)
		
		call ode1(f0+((h/2.d0)*kf1), g0+((h/2.d0)*kg1), kg2)
		call ode2(g0+((h/2.d0)*kg1), kf2)
		
		call ode1(f0+((h/2.d0)*kf2), g0+((h/2.d0)*kg2), kg3)
		call ode2(g0+((h/2.d0)*kg2), kf3)
		
		call ode1(f0+(h*kf3), g0+(h*kg3), kg4)
		call ode2(g0+(h*kg3), kf4)
		
		fx = f0 + (h/6.d0)*(kf1+2.d0*kf2+2.d0*kf3+kf4)
		gx = g0 + (h/6.d0)*(kg1+2.d0*kg2+2.d0*kg3+kg4)
		
		x0 = x
		f0 = fx
		g0 = gx
		
		call vreal(x, freal)
		relerr = abs((fx - freal)/freal)
		
		write(68,*)x, fx, freal, relerr
	end do
	
END PROGRAM p4b

SUBROUTINE ode1(fx, gx, valor)
	implicit none
	real(8),INTENT(IN)::fx, gx
	real(8),INTENT(OUT)::valor

	valor = -29.d0*fx - 4*gx 
END SUBROUTINE ode1

SUBROUTINE ode2(gx, valor)
	implicit none
	real(8),INTENT(IN)::gx
	real(8),INTENT(OUT)::valor

	valor = gx
END SUBROUTINE ode2

SUBROUTINE vreal(x, freal)
	implicit none
	real(8),INTENT(IN)::x
	real(8),INTENT(OUT)::freal
	
	freal = exp(-2.d0*x)*(cos(5.d0*x) + (2.d0/5.d0)*(sin(5.d0*x)))
END SUBROUTINE vreal
