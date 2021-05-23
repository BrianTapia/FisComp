!Resuelve la ecuación estacionaria de Schroedinger para el oscilador
PROGRAM OsciladorCuantico
  implicit none
  integer::i, j, N, Ni, Nf
  real(8),allocatable::A(:,:), d(:), e(:), tem(:)
  real(8)::h, xi, h_2, Rmin, Rmax, pot, mu, cek
  character(len=8)::ch
  real(8),parameter::R0   = 1.38488d0     ! AA
  real(8),parameter::HBAR = 6.58211d-16   ! eV*s
  real(8),parameter::c    = 2.99792d+18   ! AA/s
  real(8),parameter::MRED = 2.31637d+9/(c**2)    ! ev/c**2
  !real(8),parameter::HBAR=1.d0  ! eV*s
  !real(8),parameter::MRED=1.d0  ! ev/c**2
  real(8),parameter::V0 = 45.4521d0 ! eV
  real(8),parameter::V1 = 52.9406d0 ! eV



  Rmin = -R0/2.d0
  Rmax =  R0/2.d0

  write(6, *)Rmin, Rmax

  write(6,*)'los 6 primeros autovalores:'

  open(unit = 1, file = "data_oscilador")
  open(unit = 2, file = "potencial")

  N=1000; Nf=1000 !puntos en la malla
  do while(N.le.Nf)

     h   = (Rmax-Rmin)/N
     h_2 = 1.d0/(h**2.d0)
     mu  = 1.d0/(2.d0*MRED)
     cek = h_2*mu*(HBAR**2)

     !define las matrices
     allocate(A(N,N),d(N),e(N),tem(N))
     A = 0.d0
     d = 0.d0
     e = 0.d0

     do i=1,N
        xi   = Rmin + i*h
        pot  = V0*((tan(xi/R0))**2.d0) - V1*((sin(xi/R0))**2.d0)
        d(i) = (2.d0*cek) + pot
        e(i) = -cek
        A(i,i) = 1.d0  !matriz diagonal

        write(2,*) xi, pot
     end do

     !subrutina de diagonalizacion
     call diagotri(d,e,N,A,.true.)

     !ordeno los autovalores desde el mínimo
     do i=1,N
        do j=i+1,N
           if(d(j).lt.d(i))then
              xi=d(i); d(i)=d(j); d(j)=xi
              tem(:)=A(:,i); A(:,i)=A(:,j); A(:,j)=tem(:)
           end if
        end do
     end do

     !resultados
     write(6,"(i4,6(2x,F9.6))")N,d(1:10)

     if(N.ge.Nf/2)then
        write(1, "('#',i4,6x,10(F10.6,1x))") N/2, d(1:10)
        !norma de las funciones de onda (calculo la integral)
        tem=0.d0
        do i=1,N
           tem(:)=tem(:)+A(i,:)**2.d0
        end do
        tem=h*tem
        !guardo
        do i=1,N
           xi=Rmin+i*h
           write(1,"(11(F10.5,1x))")xi,A(i,1:10)**2.d0/tem(i)
        enddo
     end if

     deallocate(A,d,e,tem)

     N=2.d0*N

  end do

  write(6,*)
  write(6,*)'Autovectores en data_oscilador'

END PROGRAM OsciladorCuantico
