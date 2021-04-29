!funcion que se va a integrar
SUBROUTINE funcion(x,f)
  implicit none
  real(8),INTENT(IN)::x
  real(8),INTENT(OUT)::f
  
  f = exp(-0.01d0*(x**2))
  
END SUBROUTINE funcion
