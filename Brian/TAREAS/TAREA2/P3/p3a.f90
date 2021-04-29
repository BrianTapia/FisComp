PROGRAM p3a
	implicit none
	real(8)::Q, integral
	integer::i,N
	real(8),parameter::Qtot=20.d0
	
	N = 1000
	do i=1,N
		call gauss_legendre_0infty(0.1d0, i, integral)
		Q = Qtot*((2.d0*integral)**(-1.d0))
		write(65,*)i,Q
	end do
	
	write(6,*)'Q = ',Q,'statC/cm'
	write(66,*)'Q = ',Q,'statC/cm'
END PROGRAM p3a
