PROGRAM p2b
	implicit none
	real(8)::a,b,suma
	integer::j,N
	real(8)::theta_max, dtheta, armonic_lim
	real(8),PARAMETER::PI=3.1415926535897932
	logical::show_armonic
	
	!limites de integracion
	a=0.d0; b=1.d0
	
	!Definimos valor inicial de theta_max y un dtheta:
	theta_max = 0.001d0
	dtheta = 0.001d0
	
	armonic_lim = 1.d0 + 1.d0*0.01d0
	show_armonic = .true.
	do while(theta_max.le.PI)
		call simpson(a,b,theta_max,1000,suma)
		if(suma.gt.armonic_lim .and. show_armonic)then
			write(6,*)'Se comporta armónicamente hasta',theta_max,'rad.'
			show_armonic = .false.
		endif
		write(66,*)theta_max,suma
		theta_max=theta_max+dtheta
	enddo	
	
END PROGRAM p2b
