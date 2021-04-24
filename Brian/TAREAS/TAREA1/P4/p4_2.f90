program derivadaraiz
	implicit none
	
	real(8)::valorreal,rerr
	real(8)::delta, x, df
	real(8)::n
	
	x = 1
	n = 2
	open(1,file='relativeerr.dat',status='unknown')
	do while(n.le.14.0)
		delta = 10**(-n)
	
		write(6,*)10**(-2)
		df = (sqrt(x+delta)-sqrt(x))/delta
		write(6,*)df
	
		valorreal = 1/(2*sqrt(x))
	
		! Relative error.
		rerr = (valorreal - df)/valorreal
		rerr = abs(rerr)
	
		write(6,*)'n',-n,'Error relativo',rerr
		n = n+1
		
		write(1,*)delta,rerr
	enddo
	
	close(1)
end program
