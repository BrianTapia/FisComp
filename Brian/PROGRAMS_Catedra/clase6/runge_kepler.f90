!creado por Jose Mejia Lopez
!El problema de dos cuerpos usando Runge-Kutta
MODULE modKepler
  real(8),parameter::PI=3.141592653589793d0
  real(8),save,allocatable::ri(:),ti(:)
  integer,save::imaginario,signo
  real(8),save::E,L !Energia, Momento angular
  real(8),save::masaTot !masa total
  
END MODULE modKepler
!*****************************************************
PROGRAM Kepler
  !las unidades deben ser:
  !    masas en terminos de la masa de la tierra
  !    posiciones en terminos de la distancia tierra-sol (unidades astronomicas)
  !    tiempo en años
  USE modKepler
  implicit none
  !Declaration of variables
  !rc = posicion en coordenadas cartecianas
  integer::i,paso,i1,i2,N
  real(8)::rc(2,2),vc(2,2),masa(2) !variables cinematicas
  real(8)::v0(2),rcm0(2),vcm0(2),r0(2),rcm(2),r1(2),r2(2),mu
  real(8)::t,t0,tf,dt,deltat,rp,drp,rp0,rpf,Es,Ecm,Ls,Lcm
  real(8)::deltath,th0,th,p_a,p_e,rpini,alfa,dias,horas,minutos
  real(8)::mag2_v0,xx,ff,r0v0,aradial,drp0,Tun
  real(8)::k1,k2,k3,k4,disc,dmin,dmax,dtt,tcol,dt_th


  !lee informacion desde el usuario
  write(6,*)'ua = unidades astronomicas (distancia promedio Tierra-Sol)'
  do i=1,2
     write(6,"(a,i1,a)")'datos de la particula ',i,' :'
     write(6,"(a)")'masa (en terminos de la masa de la Tierra) ?'
     read(5,*)masa(i)
     write(6,"(a)")'posicion y velocidad (x0 y0 v0x v0y) en ua y ua/año ?'
     read(5,*)rc(i,:),vc(i,:)
  end do

  write(6,*)'tiempo final en años ?'
  read(5,*)tf
  write(6,*)'intervalo de cambio en el tiempo en años?'
  read(5,*)dt

  write(6,*)

  !magnitudes adimensionales con:
  !tiempo caracteristico T=sqrt(R^3/(2*G*mu))
  !masa caracteristica mu
  !distancia caracteristica R (1 unidad astronomica)
  mu=masa(1)*masa(2)/(masa(1)+masa(2)) !masa reducida
  masa=masa/mu !masas en funcion de mu 
  masaTot=masa(1)+masa(2) !masa total

  Tun=64.96255911d0*sqrt(1.d0/mu) !en años
  write(6,"(a,F10.5,a)")'Tun= ',Tun,' años'
  vc=vc*Tun
  tf=tf/Tun
  dt=dt/Tun

  !transformo condiciones iniciales al sistema del centro de masa y relativo
  rcm0(:)=(masa(1)*rc(1,:)+masa(2)*rc(2,:))/masaTot !posicion inicial del CM
  r0(:)=rc(2,:)-rc(1,:) ! posicion relativa inicial
  vcm0(:)=(masa(1)*vc(1,:)+masa(2)*vc(2,:))/masaTot !velocidad inicial del CM
  v0(:)=vc(2,:)-vc(1,:) !velocidad relativa inicial
  rp0=sqrt(dot_product(r0,r0)) !distancia radial inicial
  th0=atan2(r0(2),r0(1)) !distancia angular inicial

  write(6,"(a,F8.3,a,F12.3)")'mu= ',mu,'  Mtot= ',masaTot*mu
  
  !Energia total y momento angular total iniciales del sistema
  Es=.5d0*masa(1)*dot_product(vc(1,:),vc(1,:)) + &
       .5d0*masa(2)*dot_product(vc(2,:),vc(2,:)) - &
       0.5d0*masa(1)*masa(2)/rp0
  Ls=masa(1)*(rc(1,1)*vc(1,2)-rc(1,2)*vc(1,1)) + &
       masa(2)*(rc(2,1)*vc(2,2)-rc(2,2)*vc(2,1))
  write(6,"(a,F14.6)")'Energia total del sistema: ',Es*mu/Tun**2
  write(6,"(a,F14.6)")'Momento angular total del sistema: ',Ls*mu/Tun

  !Energia y momento angular inicial del centro de masa
  Ecm=0.5d0*masaTot*dot_product(vcm0,vcm0)
  Lcm=masaTot*(rcm0(1)*vcm0(2)-rcm0(2)*vcm0(1))

  !Energia relativa y momento angular relativo del sistema
  mag2_v0=dot_product(v0,v0)
  L=r0(1)*v0(2)-r0(2)*v0(1) !a lo largo del eje Z, perpendicular al plano
  !                               de movimiento
  E=0.5d0*mag2_v0-0.5d0*masa(1)*masa(2)/rp0

  
  write(6,"(a,F14.6)")'Energia relativa: ',E*mu/Tun**2
  write(6,"(a,F14.6)")'Momento angular relativo: ',L*mu/Tun

  p_a=2.d0*L**2/masaTot
  p_e=sqrt(1.d0+8.d0*E*L**2/(masaTot**2))

  write(6,"(a,F15.6)")'excentricidad ',p_e
  write(6,"(a,F16.6)")'parametro a: ',p_a

  !direccion entre radio y velocidad
  r0v0=dot_product(r0,v0)
  if(mag2_v0.ne.0.d0)then
     alfa=acos(r0v0/(rp0*sqrt(mag2_v0)))
     write(6,"(a,f7.2)")'angulo inicial entre velocidad y posicion: ', &
          alfa*180.d0/PI
  end if

  !direccion radial inicial
  if(abs(r0v0).lt.1.d-9)then
     aradial=L**2/rp0**3-0.5d0*masaTot/rp0**2 ! d^2 r / dt^2 
     signo=int(aradial/abs(aradial))
  else
     signo=int(r0v0/abs(r0v0))
  end if

  !puntos minimo y maximo
  disc=masaTot**2+8.d0*E*L**2
  if(disc.ge.0.d0)then
     dmin=-0.25d0*(masaTot-sqrt(disc))/E
     dmax=-0.25d0*(masaTot+sqrt(disc))/E
  else
     write(6,*)disc,' disc es negativo'; stop
  end if
  write(6,*)'rmin rmax: ',dmin,dmax

  
  !Calculo de las ecuaciones diferenciales y guarda en un archivo
  open(1,file='res_kepler.dat',status='unknown')
  write(1,"('# ',a,2x,a,8x,a,4x,a,4(8x,a))")'t(años)','r(ua)','th', &
       'r analitico','x1','y1','x2','y2'


  t0=0.d0
  N=(tf-t0)/dt+30

  
  t=0.d0; th=th0; dt_th=dt
  write(1,15)t,rp0,th0,rp0,rc(1,:),rc(2,:)
  FLUSH(1)
  write(6,"(a,i5)")'numero de datos: ',N
  allocate(ri(0:N),ti(0:N)); ri=0.d0; ri(0)=rp0; ti=0.d0
  if(abs(dmax-rp0).lt.1.d-8)ri(0)=rp0-1.d-6


  imaginario=0; paso=0; dtt=dt
  do i=1,N
11   continue
     t=t+dt; ti(i)=t
     !k1
     call funcionr(ri(i-1),k1)
     !k2 
     call funcionr(ri(i-1)+dt*k1/2.d0,k2) 
     !k3 
     call funcionr(ri(i-1)+dt*k2/2.d0,k3)
     !k4 
     call funcionr(ri(i-1)+dt*k3,k4)

     ri(i)=ri(i-1)+dt*(k1+2.d0*k2+2.d0*k3+k4)/6.d0

     if(imaginario.eq.1)then
        paso=paso+1
        if(paso.eq.2)then
           if(abs(ri(i-1)-dmax).lt.abs(ri(i-1)-dmin))then
              ri(i)=dmax-1.d-7; signo=-1
           else
              ri(i)=dmin+1.d-7; signo=1
           end if
           tcol=t-dt; dt_th=dt
           dt=dtt; paso=0
        else
           t=t-dt; dt=dt/10d0; dt_th=dt
           imaginario=0
           goto 11
        end if
        imaginario=0
     end if
     
     !condicion de colision
     if(ri(i).le.1.d-7)then
        tf=tcol*Tun
        write(6,"(a,F6.3,a,F6.3,a)")'r= ',ri(i),&
             ', el sistema colisionó al tiempo',tf,' años'
        dias=(tf-int(tf))*365.d0
        horas=(dias-int(dias))*24.d0
        minutos=(horas-int(horas))*60.d0
        write(6,"(i4,a,i3,a,i2,a,f5.2,a)")int(tf),' años ',&
             int(dias),' días ',int(horas),' horas ',minutos,' minutos'
        N=i
        exit
     end if

     if(ti(i).gt.tf)then
        N=i-1; exit
     end if

  end do   

  !calculo el angulo
  do i=1,N
     dt=ti(i)-ti(i-1); t=ti(i-1)
     !k1
     call funciontheta(i,t,k1)
     !k2
     call funciontheta(i,t+dt/2.d0,k2) 
     !k3 
     call funciontheta(i,t+dt/2.d0,k3)
     !k4 
     call funciontheta(i,t+dt,k4)

     th=th0+dt*(k1+2.d0*k2+2.d0*k3+k4)/6.d0
     
     rcm(:)=rcm0(:)+vcm0(:)*ti(i)
     r1(1)=rcm(1)-masa(2)*ri(i)*cos(th)/masaTot
     r1(2)=rcm(2)-masa(2)*ri(i)*sin(th)/masaTot
     r2(1)=rcm(1)+masa(1)*ri(i)*cos(th)/masaTot
     r2(2)=rcm(2)+masa(1)*ri(i)*sin(th)/masaTot

     write(1,15)ti(i)*Tun,ri(i),th,p_a/(1.d0+p_e*cos(th)),r1,r2
     FLUSH(1)

     th0=th
  end do
  
15 format(f9.6,1x,f10.6,1x,f10.6,1x,f10.6,3x,4(1x,f9.5))

  write(6,*)
  write(6,*)'resultados en res_kepler.dat'
  write(6,*)


END PROGRAM Kepler
!************************************************
SUBROUTINE funcionr(x,f)
  !funcion para r que se va a integrar
  USE modKepler
  implicit none
  real(8),INTENT(IN)::x
  real(8),INTENT(OUT)::f
  real(8)::ff

  ff=2.d0*E-L**2/x**2+masaTot/x
  if(ff.lt.0.d0)then
     f=0.d0; imaginario=1
     !!write(6,*)'negativo',ff,x
     return
  end if
  f=signo*sqrt(ff)

END SUBROUTINE funcionr
!************************************************
SUBROUTINE funciontheta(i,x,f)
  !funcion para theta que se va a integrar
  USE modKepler
  implicit none
  integer,INTENT(IN)::i
  real(8),INTENT(IN)::x
  real(8),INTENT(OUT)::f
  real(8)::rr

  !calculo r=r(t)
  rr=ri(i-1)+(ri(i)-ri(i-1))*(x-ti(i-1))/(ti(i)-ti(i-1))
  if(rr.le.0.d0)then
     write(6,*)x,rr,'  >>>>>>'
     stop
  end if
  f=L/rr**2

END SUBROUTINE funciontheta


