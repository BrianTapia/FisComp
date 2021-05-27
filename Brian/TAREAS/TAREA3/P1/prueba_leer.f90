PROGRAM P1A
	IMPLICIT none
	real(8)::a(10), b(10)
	INTEGER::i, N, algo

	open(1, file = 'input_prueba.dat')

	read(1, *)N, algo

	do i = 1, N
		read(1, *)a(i), b(i)
	end do

	write(6, *)algo
	write(6, *)''
	write(6, *)a
	write(6, *)''
	write(6, *)b
END PROGRAM
