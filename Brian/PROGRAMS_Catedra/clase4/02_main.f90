!calcula la integral usando el metodo Simpson
PROGRAM main_02
  implicit none
  integer::i,N,j
  real(8)::sum,a,b,freal,error

  !resultado exacto de la integral
  freal=(sin(20.d0)/20.d0+2.d0*cos(20.d0)/20.d0**2 - &
       2.d0*sin(20.d0)/20.d0**3)*100.d0
  write(6,*)'freal= ',freal; write(67,*)'# freal= ',freal

  !limites de integracion
  a=0.d0; b=1.d0

  !loop para diferentes N
  do j=1,100
     N=j!2*j !toma en cuenta los ptos medio de la malla

     call simpson(a,b,N,sum)

     error=abs(freal-sum)*100.d0/freal
     write(67,*)j,sum!,error
     
  end do

END PROGRAM main_02
