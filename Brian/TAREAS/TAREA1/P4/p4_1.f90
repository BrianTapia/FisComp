program derivadaraiz
	implicit none
	
	real(8)::valorreal,rerr
	real(8)::n, delta, x, df
	
	! Pedimos al usuario el orden de magnitud de delta.
	! Esperados: (-1, -2, -3, ...)
	write(6,*)'Ingrese el orden de magnitud de delta.'
	read(5,*)n
	
	x = 1
	delta = 10**n
	
	df = (sqrt(x+delta)-sqrt(x))/delta
	
	write(6,*)df
	
	valorreal = 1/(2*sqrt(x))
	
	! Relative error.
	rerr = (valorreal - df)/valorreal
	rerr = abs(rerr)
	
	write(6,*)'Error relativo',rerr
end program
