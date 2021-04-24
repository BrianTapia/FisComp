! Programa en Fortran: calculo del area
PROGRAM circle_area
  implicit none
  integer::i,N
  real(8)::area,perimetro
  real(8),parameter::PI=3.141592653589793d0
  real(8),allocatable::R(:)   !! POR DEFINIR.

  !solicitando numero de circulos
  write(6,*)'numero de circulos?'
  read(5,*)N

  !!! NEW:

  !localizando memoria
  !Define R.
  !El ";" es un comando completamente distinto,
  !perfectamente se podría escribir en la linea de abajo.
  allocate(R(N)); R=0.d0
  
  !leyendo datos
  !do = For (For i in range(1, N, step))
  do i=1,N!,step (default: 1).
     write(6,*)'radio del circulo',i
     read(5,*)R(i)
  enddo

  !abro archivo para guardar datos
  open(1,file='area.dat',status='unknown')
  
  !realizo calculos
  do i=1,N
     perimetro=2.d0*PI*R(i)
     area=PI*R(i)**2
     !REVISAR FORMATO PARA ESCRIBIR.
     write(1,"(a7,1x,i2,5x,a,F6.1,2(2x,a,1x,F10.5))")'circulo',i,&
          'R=',R(i),'area= ',area,'perimetro= ',perimetro
  enddo

  !cierro archivo
  close(1)

  !deslocalizo memoria
  deallocate(R)
 
END PROGRAM circle_area


!! FORMATO PARA ESCRIBIR.

! a7: a for caracteres; 7 es el len del caracter.
! a : fortran detecta solo el tamaño del caracter.

! 1x: Un espacio.
! 2x: Dos espacios.

! i2: integer (ocupa dos espacios; puedo escribir dos cifras).
!     las cifras incluyen el "-" de un numero negativo.

! F6.1: Numero real; reserva 6 espacios. Un decimal.
!       El "." gasta un espacio.

! 2(2x,a,1x,F10.5)): Repite dos veces lo que esta
!                    dentro del parentesis.

