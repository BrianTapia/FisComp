PROGRAM p1a

	implicit none
	real(8)::a,b,suma,sumagl,freal
	integer::j,N
	real(8)::errs,errgl
	real(8)::tsi,tsf,tgli,tglf
	
	!limites de integracion
	a=0.d0; b=1.d0
	
	freal = 3.627598728468435
	
	!loop para diferentes N
	do j=1,1000
	 N=j
	 call CPU_TIME(tsi)
	 call simpson(a,b,N,suma)
	 call CPU_TIME(tsf)
	 
	 call CPU_TIME(tgli)
	 call gauss_legendre(a,b,N,sumagl)
	 call CPU_TIME(tglf)
	 
	 errs = abs((freal - suma)/freal)
	 errgl = abs((freal - sumagl)/freal)
	 
	 write(66,*)j,errs,errgl,tsf-tsi,tglf-tgli
	end do
	
END PROGRAM p1a
