!Resuelve la ecuaciÃ³n estacionaria de Schroedinger para el oscilador
PROGRAM OsciladorCuantico
  implicit none
  integer::i,j,N,Ni,Nf
  real(8),allocatable::A(:,:),d(:),e(:),tem(:)
  real(8)::h,xi,h_2,Rmin,Rmax,m
  character(len=8)::ch
  real(8),parameter::R0   = 1.38488d0     ! AA
  real(8),PARAMETER::hbar =6.58119569D-16 !hbar en eV*s
  real(8),PARAMETER::V0 =45.4521d0,V1=52.9406d0!V [eV] y r [Angstrom]
  real(8),PARAMETER:: c=2.998D18  !vel de luz en angs/seg

  Rmin = -R0/2.d0
  Rmax =  R0/2.d0
  !m=1.304733646634D10/(c**2)      	!eV nitrogen
  m=2.316373055990D9/(c**2)		   	!eV reducida
  write(6,*)m

  N=200; Nf=200 !puntos en la malla
  do while(N.le.Nf)

     h=(Rmax-Rmin)/N; h_2=1.d0/h**2

     !define las matrices
     allocate(A(N,N),d(N),e(N),tem(N))
     A=0.d0; d=0.d0; e=0.d0
     do i=1,N
        xi=Rmin+i*h
        d(i)=((hbar**2)*h_2/m)+(V0*(tan(xi/r0))**2-V1*(sin(xi/r0))**2) !d(i)=(2.d0*h_2)+(xi*xi)
        e(i)=-((hbar**2)*h_2/(2.d0*m))
        A(i,i)=1.d0  !matriz diagonal
     end do

     !subrutina de diagonalizacion
     call diagotri(d,e,N,A,.true.)

     !ordenos los autovalores desde el mÃ­nimo
     do i=1,N
        do j=i+1,N
           if(d(j).lt.d(i))then
              xi=d(i); d(i)=d(j); d(j)=xi
              tem(:)=A(:,i); A(:,i)=A(:,j); A(:,j)=tem(:)
           end if
        end do
     end do

     !resultados
     write(6,"(i4,8(2x,F9.6))")N,d(1:8)

     if(N.ge.Nf/2)then
        open(unit=1,file="data_oscilador.dat",status="unknown")
        write(1,"('#',i4,6x,8(F10.6,1x))")N/2,d(1:8)
        !norma de las funciones de onda (calculo la integral)
        tem=0.d0
        do i=1,N
           tem(:)=tem(:)+A(i,:)**2
        end do
        tem=h*tem
        !guardo
        do i=1,N
           xi=Rmin+i*h
           write(1,"(9(F10.5,1x))")xi,A(i,1:8)**2/tem(i)
        enddo
     end if

     deallocate(A,d,e,tem)

     N=2*N

  end do

  write(6,*)
  write(6,*)'Autovectores en data_oscilador'

END PROGRAM OsciladorCuantico
