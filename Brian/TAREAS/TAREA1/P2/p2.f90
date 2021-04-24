PROGRAM deg2eqsol
	implicit none
	
	real(8)::pr1,pr2,pi1,pi2
	real(8)::a,b,c
	real(8)::discriminant
	
	! Consulta al usuario por los 3 coeficientes de la ecuación.
	write(6,*)'Escoja 3 numeros reales: a,b,c (uno por uno).'
	do while(1.eq.1)
		write(6,*)'a: '
		read(5,*)a
		if(a.ne.0.0)then
			exit
		elseif(a.eq.0.0)then
			write(6,*)'Escoja "a" distinto de 0'
		endif
	enddo
	write(6,*)'b: '
	read(5,*)b
	write(6,*)'c: '
	read(5,*)c
	! FIN de la consulta.
	
	! Defino el discriminante para ocuparlo posteriormente en las
	! soluciones.
	discriminant = b**2 - 4*a*c
	
	! Condicionales para saber si las soluciones son reales o 
	! imaginarias
	
	! En estricto rigor, esto es ver si el discriminante es positivo
	! o negativo, pero lo hacemos así para evitar la resta y el posible
	! error en la resta de cifras significativas.
	
	! Raices reales:
	if(b**2 .ge. 4*a*c)then
		pr1 = (-b + (discriminant)**(0.5))/(2*a)
		pr2 = (-b - (discriminant)**(0.5))/(2*a)
		write(6,*)pr1,'Raiz Real'
		write(6,*)pr2,'Raiz Real'
	ENDIF
	
	!Raices complejas:
	if(b**2 .lt. 4*a*c)then
		pr1 = (-b)/(2*a)
		pr2 = (-b)/(2*a)

		pi1 = ((-1*discriminant)**(0.5))/(2*a)
		pi2 = ((-1*discriminant)**(0.5))/(2*a)
		write(6,*)pr1,'+',pi1,'i Raiz Compleja'
		write(6,*)pr2,'-',pi2,'i Raiz Compleja'
	ENDIF
		
END PROGRAM
