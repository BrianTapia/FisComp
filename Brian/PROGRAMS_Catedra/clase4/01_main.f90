!calcula la integral usando el metodo rectangular
PROGRAM main01
  implicit none
  integer::N
  real(8)::sum,a,b,freal,error
  
  !resultado exacto de la integral
  freal=(sin(20.d0)/20.d0+2.d0*cos(20.d0)/20.d0**2 - &
       2.d0*sin(20.d0)/20.d0**3)*100.d0

  write(6,*)'freal= ',freal; write(66,*)'# freal= ',freal

  !limites de integracion
  a=0.d0; b=1.d0

  !loop para diferentes N
  do N=1,10000

     call rectangular(a,b,N,sum)

     error=abs(freal-sum)*100.d0/freal
     write(66,*)N,sum,error

  end do

END PROGRAM main01
