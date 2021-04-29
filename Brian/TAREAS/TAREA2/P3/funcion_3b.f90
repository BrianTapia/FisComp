!funcion que se va a integrar
SUBROUTINE funcion(x,z,f)
  implicit none
  real(8),INTENT(IN)::x,z
  real(8),INTENT(OUT)::f
  real(8),PARAMETER::Q=1.1282201840500843d0
  
  f = (Q*exp(-0.01d0*(x**2.d0)))/((x**2.d0 + z**2.d0)**(0.5d0))
  
END SUBROUTINE funcion
