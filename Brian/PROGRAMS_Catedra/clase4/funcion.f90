!funcion que se va a integrar
SUBROUTINE funcion(x,f)
  implicit none
  real(8),INTENT(IN)::x
  real(8),INTENT(OUT)::f
  real(8)::d,dd
  
  f=100.d0*cos(20.d0*x)*x**2

  !f=exp(-x)


END SUBROUTINE funcion
