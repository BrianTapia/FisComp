PROGRAM p2c
	implicit none
	integer::i,N
	real(8)::k1,k2,k3,k4,t,t0,tf,h
	real(8)::theta_max, theta, theta0,w0
	real(8),PARAMETER::PI=3.1415926535897932
	logical::show_armonic
	
	! Omega 0
	w0 = 1.d0
	
	! theta_max:
	theta_max = 0.09d0*PI ! Energía inicial 2mgl.
	
	! Condiciones iniciales:
	theta0 = theta_max
	t0 = 0.d0
	
	! Tiempo final:
	tf=3.d0*(2.d0*PI/w0) !3 periodos
	
	! Pasos:
	h=0.1d0; N=(tf-t0)/h
	
	do i=1,N
		t = t0+h
		
		call ode(theta0,w0,theta_max,k1)
		call ode(theta0+(h/2.d0)*k1,w0,theta_max,k2)
		call ode(theta0+(h/2.d0)*k2,w0,theta_max,k3)
		call ode(theta0+(h*k3),w0,theta_max,k4)
		
		theta = theta0 + (h/6.d0)*(k1+2.d0*k2+2.d0*k3+k4)
		
		t0 = t
		theta0 = theta
		
		write(66,*)t,theta
	end do
	
END PROGRAM p2c

SUBROUTINE ode(theta,w0,theta_max,thetap)
	implicit none
	real(8),INTENT(IN)::theta,w0,theta_max
	real(8),INTENT(OUT)::thetap
	real(8)::f1, f2
	
	f1 = sin(theta_max/2.d0)**2.d0
	f2 = sin(theta/2.d0)**2.d0
	
	thetap = 2.d0*w0*sqrt(f1 - f2)
END SUBROUTINE ode
