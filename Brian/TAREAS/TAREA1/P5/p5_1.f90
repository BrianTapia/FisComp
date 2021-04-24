program sustrac
	implicit none
	
	real(8)::x
	real(8)::directo,alt
	
	x = 0.000001
	open(1,file='p5_1.dat',status='unknown')
	do while(x.le.1e-4)
		directo = sqrt(x**2 + 1) - 1
		
		alt = (x**(2))/(sqrt(x**2 + 1) + 1)
	
		
		write(1,*)x, directo, alt, directo/alt
		
		x = x + (4e-6)
	enddo
	close(1)
end program
