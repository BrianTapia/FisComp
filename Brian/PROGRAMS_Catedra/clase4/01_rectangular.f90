!calcula la integral usando el metodo rectangular
SUBROUTINE rectangular(a,b,N,sum)
  implicit none
  integer,INTENT(IN)::N
  real(8),INTENT(IN)::a,b
  real(8),INTENT(OUT)::sum
  integer::i
  real(8)::x,fx,h,w
  
  !calculo h
  h=(b-a)/N

  !defino los pesos
  w=1.d0

  !calculo la integral
  sum=0.d0; x=a
  do i=1,N+1
     call funcion(x,fx)
     sum=sum+w*fx
     x=x+h
  end do
  sum=sum*h
  
END SUBROUTINE rectangular
