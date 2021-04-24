!Programa en Fortran: calculo del area.
PROGRAM circle_area
  
  !Implicit none para estar obligado a definir
  !las variables que uno va a utilizar. Evitar errores.
  implicit none

  !Integer: Variable entera. (:: para empezar a
  !         definir las variables.
  integer::i,N

  !Real: Variable real.
  !      (8): 2*8 = 16 cifras significativas.
  real(8)::area,perimetro

  !parameter: se utiliza para que la variable
  !           no cambie nunca.
  real(8),parameter::PI=3.141592653589

  !allocatable: El programa va a localizar la variable después.
  !R(:)     = La variable va a ser un vector.
  !M(:,:)   = La variable va a ser una matriz.
  !T(:,:,:) = La variable sería un tensor de largo 3.
  real(8),allocatable::R(:)

  !Se puede crear una variable compleja:
  !complex(8)::z

  !Variable de tipo caracter:
  !character(len=n)::c(6); n: longitud del caracter.

  !Variable del tipo booleano:
  !logical (T o F).

  
  !Solicitando numero de circulos

  !!!Escribir en pantalla algo:

  !6 Significa el dispositivo
  !(6 está reservado para la pantalla)

  !* Significa formato libre.
  !El compilador lo elige.
 
  write(6,*)'numero de circulos?'

  !!!Leer algo de la pantalla.
  !5 reservado para la pantalla.
  !* formato libre.

  !N lo tenemos que escribir (como un imput)

  read(5,*)N
