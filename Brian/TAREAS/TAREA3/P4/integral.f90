! MIN: 249
! MAX: 551

PROGRAM TUNEL
	IMPLICIT none
	INTEGER::i
	REAL(8)::x(0:800), u2(0:800)
	real(8),parameter::R0   = 1.38488d0     ! AA
	REAL(8)::Rmin, Rmax, h, N = 800

	Rmin = -R0/2.d0
  Rmax =  R0/2.d0
	h    = (Rmax-Rmin)/N

	open(1, file = 'prob_u2')
	do i = 0, 600 ! No es el final del archivo, pero es suficiente.
		read(1, *)x(i), u2(i)
	end do

	! Calculamos la integral multiplicando por el dx = h.
	write(6, *)sum(u2(248:551)*h)

END PROGRAM TUNEL
