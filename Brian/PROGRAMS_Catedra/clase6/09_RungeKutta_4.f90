!método de Runge-Kutta de cuarto orden (RK4).
!Solucion del oscilador armonico simple
PROGRAM RK4
  implicit none
  real(kind(1.d0)),parameter::PI=3.141592654d0
  integer::i,N
  real(kind(1.d0))::t0,x0,v0,t,x,v,tf,h,omega,Ener,masa
  real(kind(1.d0))::kx1,kx2,kx3,kx4,kv1,kv2,kv3,kv4
  REAL(8)::time1,time2

  CALL CPU_TIME(time1)
  
  !parametros fisicos del oscilador
  omega=1.d0; masa=0.1d0

  !condiciones iniciales
  t0=0.d0; x0=5.d0; v0=0.d0

  !tiempo final
  tf=3.d0*(2.d0*PI/omega) !omega^2=k/m => T=2Pi/omega y quiero 3 periodos

  !tamaños de paso (puntos de la malla en el intervalo dado)
  h=0.1d0; N=(tf-t0)/h
  
  write(66,"(5(1x,F12.6))")t0,x0,v0,0.5d0*masa*x0**2,0.d0

  !Solucion de la ecuación diferencial que representa el oscilador
  do i=1,N
     
     t=t0+h
     !k1 para la posicion y la velocidad
     kx1=v0; kv1=-omega**2*x0 
     !k2 para la posicion y la velocidad
     kx2=v0+h*kv1/2.d0; kv2=-omega**2*(x0+h*kx1/2.d0)
     !k3 para la posicion y la velocidad
     kx3=v0+h*kv2/2.d0; kv3=-omega**2*(x0+h*kx2/2.d0)
     !k4 para la posicion y la velocidad
     kx4=v0+h*kv3; kv4=-omega**2*(x0+h*kx3)

     x=x0+h*(kx1+2.d0*kx2+2.d0*kx3+kx4)/6.d0 !posicion calculado con RK4
     v=v0+h*(kv1+2.d0*kv2+2.d0*kv3+kv4)/6.d0 !velocidad calculado con RK4

     Ener=0.5d0*masa*v**2+0.5d0*masa*omega**2*x**2 !energia total: E = K + U

     write(66,"(5(1x,F12.6))")t,x,v,Ener,&
          (5.d0*cos(omega*t)-x)/(5.d0*cos(omega*t))

     t0=t; x0=x; v0=v !avanza en el tiempo
     
  end do

  CALL CPU_TIME(time2)
  write (6,*) "tiempo de corrida:",time2-time1, " seg"
  
END PROGRAM RK4

