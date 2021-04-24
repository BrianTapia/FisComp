!funcion que se va a integrar. f = T/T0.
SUBROUTINE funcion(x, theta_max,f)
  implicit none
  real(8),INTENT(IN)::x, theta_max
  real(8),INTENT(OUT)::f
  real(8),PARAMETER::PI=3.1415926535897932
  real(8)::f1,f2,alpha
  
  alpha = sin(theta_max/2)
  
  f1 = sqrt(2.d0-(x**2.d0))
  f2 = sqrt(1.d0-(alpha**2.d0*((1.d0-x**2.d0)**2.d0)))
  
  
  f = (4.d0/PI)*(1/(f1*f2))
  
END SUBROUTINE funcion
