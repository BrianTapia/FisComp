PROGRAM extrapolate
	implicit none
	
	integer::i,N
	
	!ext servirá para almacenar los valores
	!que queremos obtener de la extrapolación.
	integer,allocatable::ext(:) 
	
	!definimos las variables obtenidas en 
	!el ajuste del polinomio de grado 2.
	real(8),parameter::a=0.33125d0,b=-3.65d0,c=18d0
	
	!definimos el desplazamiento de la funcion.
	real(8),parameter::x0=1990d0
	
	!definimos una variable para el valor de la extrapolacion.
	real(8)::extval
	
	!Preguntamos cuantos valores quiere extrapolar
	!el usuario, para definir ext.
	write(6,*)'Numero de puntos para extrapolar?'
	read(5,*)N
	
	allocate(ext(N))
	open(1,file='extrapolations.dat',status='unknown')
	
	do i=1,N
		write(6,*)'Ingrese año'
		read(5,*)ext(i) 
		extval = a*(ext(i)-x0)**2+b*(ext(i)-x0)+c
		!Escribimos el valor extrapolado en un archivo.
		write(1,"(i4,1x,F4.1)")ext(i),extval
	enddo
	
	close(1)
	deallocate(ext)
	
END PROGRAM extrapolate
		
