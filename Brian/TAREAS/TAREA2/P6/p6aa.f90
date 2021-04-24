MODULE modp4
	real(8),parameter  ::m=1.d0, l=1.d0, g=9.80665
	real(8)            ::f0, f1, f2, f3, f4
END MODULE modp4


PROGRAM p4b
	implicit none
	integer::i,N
	real(8)::t, t0, tf, h
	real(8)::p1_t,p2_t,phi1_t,phi2_t ! En el nodo actual.
	real(8)::p1_0,p2_0,phi1_0,phi2_0 ! En el nodo anterior.
	real(8)::auxp1, auxp2, auxphi1, auxphi2 ! Auxiliares
	
	! Constantes:
	real(8)::p1_k1, p2_k1, phi1_k1, phi2_k1
	real(8)::p1_k2, p2_k2, phi1_k2, phi2_k2
	real(8)::p1_k3, p2_k3, phi1_k3, phi2_k3
	real(8)::p1_k4, p2_k4, phi1_k4, phi2_k4
	
	! Coordenadas en el espacio real:
	real(8)::x1, x2, y1, y2
	
	! Condiciones iniciales:
	t0 = 0.d0
	phi1_0 = 0.d0; phi2_0 = 0.d0
	p1_0 = 4.d0; p2_0 = 2.d0
	
	x1 = sin(phi1_0)
	y1 = 2.d0-cos(phi1_0)
	
	x2 = sin(phi1_0) + sin(phi2_0)
	y2 = 2.d0 - cos(phi1_0) - cos(phi2_0)
	
	! Pasos e intervalo de solución:
	tf = 80.d0
	h = 0.01d0; N = (tf - t0)/h
	
	open(66, file = 'espacio_phi.dat')
	open(67, file = 'espacio_p.dat')
	open(68, file = 'espacio_real.dat')
	
	!Escribimos las coordenadas en el tiempo inicial:
	write(66,*)t0, phi1_0, phi2_0
	write(67,*)t0, p1_0, p2_0
	write(68,*)t0, x1, y1, x2, y2
	
	do i=1,N
		t = t0+h
		
		write(6,*)'phi1', phi1_0
		
		call dphi1(phi1_0,phi2_0,p1_0,p2_0,phi1_k1)
		call dphi2(phi1_0,phi2_0,p1_0,p2_0,phi2_k1)
		call dp1(phi1_0,phi2_0,p1_0,p2_0,p1_k1)
		call dp2(phi1_0,phi2_0,p1_0,p2_0,p2_k1)
		
		auxphi1 = phi1_0 + (h/2.d0)*phi1_k1
		auxphi2 = phi2_0 + (h/2.d0)*phi2_k1
		auxp1   = p1_0 + (h/2.d0)*p1_k1
		auxp2   = p2_0 + (h/2.d0)*p2_k1
		
		call dphi1(auxphi1,auxphi2,auxp1,auxp2,phi1_k2)
		call dphi2(auxphi1,auxphi2,auxp1,auxp2,phi2_k2)
		call dp1(auxphi1,auxphi2,auxp1,auxp2,p1_k2)
		call dp2(auxphi1,auxphi2,auxp1,auxp2,p2_k2)
		
		auxphi1 = phi1_0 + (h/2.d0)*phi1_k2
		auxphi2 = phi2_0 + (h/2.d0)*phi2_k2
		auxp1   = p1_0 + (h/2.d0)*p1_k2
		auxp2   = p2_0 + (h/2.d0)*p2_k2
		
		call dphi1(auxphi1,auxphi2,auxp1,auxp2,phi1_k3)
		call dphi2(auxphi1,auxphi2,auxp1,auxp2,phi2_k3)
		call dp1(auxphi1,auxphi2,auxp1,auxp2,p1_k3)
		call dp2(auxphi1,auxphi2,auxp1,auxp2,p2_k3)
		
		auxphi1 = phi1_0 + (h)*phi1_k3
		auxphi2 = phi2_0 + (h)*phi2_k3
		auxp1   = p1_0 + (h)*p1_k3
		auxp2   = p2_0 + (h)*p2_k3
		
		call dphi1(auxphi1,auxphi2,auxp1,auxp2,phi1_k4)
		call dphi2(auxphi1,auxphi2,auxp1,auxp2,phi2_k4)
		call dp1(auxphi1,auxphi2,auxp1,auxp2,p1_k4)
		call dp2(auxphi1,auxphi2,auxp1,auxp2,p2_k4)
		
		phi1_t = phi1_0 + (h/6.d0)*(phi1_k1 + 2.d0*phi1_k2 + 2.d0*phi1_k3 + phi1_k4)
		phi2_t = phi2_0 + (h/6.d0)*(phi2_k1 + 2.d0*phi2_k2 + 2.d0*phi2_k3 + phi2_k4)
		p1_t = p1_0 + (h/6.d0)*(p1_k1 + 2.d0*p1_k2 + 2.d0*p1_k3 + p1_k4)
		p2_t = p2_0 + (h/6.d0)*(p2_k1 + 2.d0*p2_k2 + 2.d0*p2_k3 + p2_k4)
		
		x1 = sin(phi1_t)
		y1 = 2.d0-cos(phi1_t)
		
		x2 = sin(phi1_t) + sin(phi2_t)
		y2 = 2.d0 - cos(phi1_t) - cos(phi2_t)
		
		write(66,*)t, phi1_t, phi2_t
		write(67,*)t, p1_t, p2_t
		write(68,*)t, x1, y1, x2, y2
		
		phi1_0 = phi1_t
		phi2_0 = phi2_t
		p1_0 = p1_t
		p2_0 = p2_t
		t0 = t
		
	end do
	
	close(66)
	close(67)
	close(68)
	
END PROGRAM p4b

SUBROUTINE dphi1(phi1,phi2,p1,p2,F)
	use modp4
	implicit none
	real(8)::DP
	real(8),INTENT(IN)::phi1,phi2,p1,p2
	real(8),INTENT(OUT)::F
	DP = phi1-phi2
	
	F = (p1-p2*cos(DP))/(m*l*l*(1+(sin(DP))**2))
END SUBROUTINE dphi1

SUBROUTINE dphi2(phi1,phi2,p1,p2,F)
	use modp4
	implicit none
	real(8)::DP
	real(8),INTENT(IN)::phi1,phi2,p1,p2
	real(8),INTENT(OUT)::F
	DP = phi1-phi2
	
	F = (2*p2-p1*cos(DP))/(m*l*l*(1+(sin(DP))**2))
END SUBROUTINE dphi2

SUBROUTINE dp1(phi1,phi2,p1,p2,F)
	use modp4
	implicit none
	real(8)::DP
	real(8),INTENT(IN)::phi1,phi2,p1,p2
	real(8),INTENT(OUT)::F
	DP = phi1-phi2
	
	F = (((p1**2+2*p2**2-2*p1*p2*cos(DP))/(1+(sin(DP))**2))*cos(DP)*sin(DP)-&
	p1*p2*sin(DP))/(m*l*l*(1+(sin(DP))**2))-2*m*g*l*sin(phi1)
END SUBROUTINE dp1

SUBROUTINE dp2(phi1,phi2,p1,p2,F)
	use modp4
	implicit none
	real(8)::DP
	real(8),INTENT(IN)::phi1,phi2,p1,p2
	real(8),INTENT(OUT)::F
	DP = phi1-phi2
	
	F = (((p1**2+2*p2**2-2*p1*p2*cos(DP))/(1+(sin(DP))**2))*cos(DP)*sin(DP)-&
	p1*p2*sin(DP))/(m*l*l*(1+(sin(DP))**2))-m*g*l*sin(phi2)
END SUBROUTINE dp2
