!funcion que se va a integrar
SUBROUTINE funcion(x,f)
  implicit none
  real(8),INTENT(IN)::x
  real(8),INTENT(OUT)::f
  real(8)::f1,f2
  
  f1 = 1.d0 - x**3.d0
  f2 = (x**6.d0 - 3.d0*x**3.d0 + 3.d0)**(2.d0/3.d0)
  
  f = 9.d0 * f1/f2
  
  
  !write(6,*)f
  
END SUBROUTINE funcion
