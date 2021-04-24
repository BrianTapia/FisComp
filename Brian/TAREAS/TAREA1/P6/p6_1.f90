program energiamedia
	implicit none
	
	real(8),parameter::kb=8.617333262145e-5 !eV/K
	real(8),parameter::w=1.13e13 !rad/s
	real(8),parameter::hbar=6.582119569e-16 !eV*s
	
	real(8)::beta,hw
	real(8)::T,En,n,totN
	real(8)::expbEn
	real(8)::Z, sE, mE
	
	real(8)::totNs(5),time1,time2
	
	integer(8)::i
	

	T = 1e4 !K
		
	beta = 1.0/(kb*T) !eV
	hw   = hbar*w !eV**2*rad
	

	totNs = (/ 3.0, 4.0, 5.0, 6.0, 9.0 /)
	
	n = 0
	En = 0

	open(1,file='p6_1.dat',status='unknown')
	
	! Primer do, para correr sobre los distintos N.
	do i = 1,5
		totN = 10.0**totNs(i)
		CALL CPU_TIME(time1)
		
		! Segundo ciclo. Realiza todas las sumas respetando
		! los rasgos pedidos en la P6.a)
		do while(n.le.totN)
			
			En = hw*(n+(1.0/2.0))
			
			! Calcula la exponencial.
			expbEn = exp(-1.0*beta*En)
			
			! Sumas parciales.
			Z  = Z + expbEn
			sE = sE + En*expbEn
		
			n = n+1.0
		enddo
		
		CALL CPU_TIME(time2)
	
		! Energia media: Relación para obtener valor final.
		mE = sE/Z
		
		write(6,*)mE, time2-time1
		write(1,*)totN, mE, time2-time1
	enddo
	
	close(1)
	
end program
