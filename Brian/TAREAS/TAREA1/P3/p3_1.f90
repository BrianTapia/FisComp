PROGRAM freeparticle
	implicit none

	! Definimos la constante de aceleración gravitatoria:
	real(8),parameter::g=9.80665 !m/s**2
	
	! h: altura inicial (en m).
	! e: coeficiente de inelasticidad.
	! endt: tiempo de la simulación. Condición secundaria de término.
	real(8)::h,e,endt
	
	! v: velocidad en todo t.
	! v0: Condiciones iniciales (al inicio de la simulación o después
	!     de un bote.
	
	! Análogo para y.
	real(8)::v,v0
	real(8)::y,y0
	
	! totalt: tiempo total transcurrido.
	! t     : tiempo dentro de un loop a realizar por cada rebote
	! dt    : step del tiempo total transcurrido.
	! tmax  : tiempo entre rebotes.
	! deltat: se explicará más adelante.
	real(8)::totalt,t,dt,tmax,deltat
	
	! Pedimos al usuario una alura inicial.
	do while(1.eq.1)
		write(6,*)'Ingrese una altura inicial (positiva) en metros:'
		read(5,*)h
		if(h.gt.0)then
			exit
		! No permite alturas menores o iguales a 0.
		else
			write(6,*)'Altura inválida'
		endif
	enddo
	
	! Pedimos al usuario un coeficiente de restitución inicial.
	do while(1.eq.1)
		write(6,*)'Ingrese un coeficiente de restitución inicial:'
		read(5,*)e
		if(e.ge.0 .and. e.le.1)then
			exit
		else
			write(6,*)'Coeficiente inválido'
		endif
	enddo
	
	! Pedimos al usuario un tiempo final (en segundos).
	! Este tiempo se interpreta como: No hay más botes en t.ge.endt
	! Será una condicion secundaria de término.
	write(6,*)'Se definirá el tiempo inicial en 0 segundos.'
	write(6,*)'Ingrese el tiempo final para la simulación (segundos):'
	read(5,*)endt
	
	totalt = 0.0d0
	
	t  = 0.0d0
	dt = 0.05d0
	
	y  = h
	
	! Condiciones iniciales.
	y0 = h
	v0 = 0.0d0
	
	open(1,file='freep1.dat',status='unknown')
	
	! Comenzamos el loop principal.
	do while(totalt.le.endt)

		! Condición de entrada al subloop por bote:
		! Calculamos analíticamente el tiempo teórico en el que la 
		! partícula debería tocar el suelo (y = 0). 
		! (Tiempo entre rebotes).
		if(y0.ne.0 .and. v0.eq.0)then
			tmax = sqrt((2*y0)/g)
		endif

		if(y0.eq.0)then
			tmax = (2*v0)/g
		endif
		
		! Condición principal de salida.
		! Para evitar errores en el do while (evitar que no salga del
		! loop), definimos esta condición.
		! Si el tiempo entre rebotes es menor o igual que el diferencial
		! de tiempo que estamos ocupando, termina la simulación.
		if(tmax.le.dt)then
			exit
		endif
		
		! Subloop por bote: Calcula y, v para cada t menor a tmax.
		! 					Guarda la info en 1.
		do while(t.le.tmax)
			write(6,*)'Subloop', totalt
			y = y0 + v0*t - 0.5*(g*t**2)
			v = v0 - g*t
			
			write(1,*)0.0d0,totalt,y
			
			t = t+dt
			totalt = totalt+dt
		enddo
		
		! En la última iteración del loop anterior debemos obtener un t
		! igual o mayor a tmax. En este caso, nos interesa redefinir las
		! condiciones iniciales del problema, adaptándolas segun el 
		! modelo de choque que nos entregue el parámetro "e".
		! Esto se entiende como un "nuevo rebote", y a parte de 
		! resetear las condiciones iniciales, resetea el tiempo "t" a 0.
		if(t.gt.tmax)then
			write(6,*)'Bote. Reseteando parámetros.'
			
			! Nos interesa graficar el momento exacto del rebote. Por lo
			! que redefino totalt y guardo ese punto exacto,
			! evaluando en tmax.
			
			!deltat: Diferencia entre el totalt y el punto de rebote.
			deltat = tmax-t
			y = y0 + v0*tmax - 0.5*(g*tmax**2)
			v = v0 - g*tmax
			write(1,*)0.0d0,totalt+deltat,y
			
			y0 = 0
			
			! Define el choque.
			v0 = -1*e*v
			
			! Acá es muy conflictivo que dt sea mayor que tmax, por ello
			! definimos la condicion principal de salida.
			t = dt - tmax + t
			totalt = totalt+dt
			
		endif
		
		! A partir de acá el loop continúa, ahora con t = 0 y las
		! nuevas condiciones iniciales, se vuelve a entrar en el 
		! subloop por rebote.
		
		! Notamos que totalt, a excepción del momento de reseteo de 
		! parámetros, siempre aumenta.
		
		

		
	enddo
	
	close(1)
	
END PROGRAM	
	
	
