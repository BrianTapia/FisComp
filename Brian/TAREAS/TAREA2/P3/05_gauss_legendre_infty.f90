!Integra usando cuadraturas de Gauss_Legendre entre 0 e infinito
SUBROUTINE gauss_legendre_0infty(a,N,integral)
  implicit none
  integer,INTENT(IN)::N
  real(8),INTENT(IN)::a
  real(8),INTENT(OUT)::integral
  integer::k
  real(8)::fx,xi,wi
  real(8),ALLOCATABLE:: x(:),w(:)

  INTERFACE
     SUBROUTINE gauleg(x1,x2,x,w)
       IMPLICIT NONE
       INTEGER,PARAMETER::DP=kind(1.d0)
       REAL(DP),INTENT(IN)::x1,x2
       REAL(DP),INTENT(OUT)::x(:),w(:)
     END SUBROUTINE gauleg
  END INTERFACE


  allocate(x(N),w(N)) !localiza memoria

  call gauleg(-1.d0,1.d0,x,w) !puntos de la malla y pesos Gauss-Legendre

  ! cuadratura Gaussiana
  integral=0.d0
  do k=1,N
     xi=a*(1.d0+x(k))/(1.d0-x(k))
     call funcion(xi,fx)
     wi=2.d0*a*w(k)/(1-x(k))**2
     integral=integral+wi*fx
  end do
  
  deallocate(x,w) !libera memoria
  
END SUBROUTINE gauss_legendre_0infty

!********** Calculo de los puntos de la malla y pesos (Gauss-Legendre)****
!BASADO EN NUMERICAL RECIPES
SUBROUTINE gauleg(x1,x2,x,w)
  IMPLICIT NONE
  INTEGER,PARAMETER::DP=kind(1.d0)
  REAL(DP),INTENT(IN)::x1,x2
  REAL(DP),INTENT(OUT)::x(:),w(:)
  REAL(DP),PARAMETER::EPS=3.0e-14_dp
  !Given the lower and upper limits of integration x1 and x2, this routine 
  !returns arrays x and w of length N containing the abscissas and weights 
  !of the Gauss-Legendre N-point quadrature formula. The parameter EPS is 
  !the relative precision. 
  INTEGER::its,j,m,n,i
  INTEGER,PARAMETER::MAXIT=10
  REAL(DP),PARAMETER::PI=3.141592654d0
  REAL(DP)::xl,xm
  REAL(DP),DIMENSION((size(x)+1)/2)::p1,p2,p3,pp,z,z1
  LOGICAL,DIMENSION((size(x)+1)/2)::unfinished
  
  if(size(x).eq.size(w))then
     n=size(x)
  else
     write(6,*)'error en las dimensiones de los puntos de la malla y pesos'
     stop
  end if
  m=(n+1)/2 !The roots are symmetric in the interval,so we only have to find half of them.
  xm=0.5d0*(x2+x1) 
  xl=0.5d0*(x2-x1)
  do i=1,m
     z(i)=cos(PI*(i-0.25d0)/(n+0.5d0))!Initial approximations to the roots
  end do
  unfinished=.true.
  do its=1,MAXIT !Newton’s method carried out simultanously on the roots.
     where(unfinished) 
        p1=1.d0
        p2=0.d0
     end where
     do j=1,n !Loop up the recurrence relation to get the Legendre polynomials evaluated at z.
        where (unfinished)
           p3=p2
           p2=p1
           p1=((2.d0*j-1.d0)*z*p2-(j-1.d0)*p3)/j
        end where
     end do
     !p1 now contains the desired Legendre polynomials. We next compute 
     !pp, the derivatives,by a standard relation involving also p2, 
     !the polynomials of one lower order.
     where (unfinished)
        pp=n*(z*p1-p2)/(z*z-1.0_dp)
        z1=z
        z=z1-p1/pp !Newton’s method.
        unfinished=(abs(z-z1) > EPS)
     end where
     if (.not. any(unfinished)) exit
  end do
  if (its == MAXIT+1)then
     write(6,*)'too many iterations in gauleg'; stop
  end if
  x(1:m)=xm-xl*z !Scale the root to the desired interval,
  x(n:n-m+1:-1)=xm+xl*z !and put in its symmetric counterpart.
  w(1:m)=2.d0*xl/((1.d0-z**2)*pp**2) !Compute the weight
  w(n:n-m+1:-1)=w(1:m) !and its symmetric counterpart.
END SUBROUTINE gauleg

