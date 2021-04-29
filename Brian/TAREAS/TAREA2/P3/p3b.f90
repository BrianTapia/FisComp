PROGRAM p3b
	implicit none
	integer::i, N ! Numero de iteraciones para z.
	real(8)::z, dz 
	real(8)::integral, V
	
	N = 1000
	dz = 0.5d0
	z = 0.d0
	
	do i=1,N
		z = z+dz
		write(6,*)z
		call mod_0infty(z, 0.1d0, 100, integral)
		write(6,*)z
		
		V = 2.d0*integral
		write(67,*)z,V
	end do
	
END PROGRAM p3b
