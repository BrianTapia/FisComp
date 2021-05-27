PROGRAM P2A
	IMPLICIT none
	INTEGER::N, i, j
	REAL(8)::V1(7), V2, h, eps
	REAL(8)::L1, L2, s(7), z(7), C(7)
	REAL(8),ALLOCATABLE::V(:, :)
	LOGICAL,ALLOCATABLE::es_conductor(:, :)

	L1 = 25.d0

	! Dado que la región es cuadrada, utilizamos el mismo N en ambos ejes.
	N  = 250
	h = L1/N
	ALLOCATE(V(0:N, 0:N), es_conductor(0:N, 0:N))

	! Precisión:
	eps = 1.d-6

	! Manteniendo V2 fijo, generamos V1 tal que la diferencia sea la estipulada
	! en el enunciado:
	V1 = (/6.d0, 7.d0, 10.d0, 15.d0, 20.d0, 25.d0, 30.d0/)
	V2 = 5.d0

	do i = 1, 7
		call red_inicial(N, V1(i), V2, V, es_conductor)
		call Poisson(N, eps, es_conductor, V)
		call guardar(N, L1, h, V)
		call Q(N, L1, h, V, s(i), z(i))

		write(6, *)'DV = ', V1(i) - V2
		write(6, *)'Carga Q en L1: ', s(i)
		write(6, *)'Carga Q en L2: ', z(i)
		write(6, *)'Capacitancia : ', (abs(s(i))+abs(z(i)))/(2*(V1(i)-V2))
		write(6, *)'Razón: ', (s(i)+z(i))/(2*(abs(s(i))+abs(z(i)))/(2*(V1(i)-V2)))
		write(6, *)''
	end do



END PROGRAM

SUBROUTINE red_inicial(N, V1, V2, V, es_conductor)
  implicit none
  integer,INTENT(IN)::N
  real(8),INTENT(IN)::V1, V2
  real(8),dimension(0:N, 0:N),INTENT(OUT)::V
  logical,dimension(0:N, 0:N),INTENT(OUT)::es_conductor
	INTEGER::N25, N35
  INTEGER::i, j

  !inicia la red con valores 0 and .FALSE.
  V = 0.d0
  es_conductor = .FALSE.

  ! ponemos las condiciones de frontera (conductores)
	!! Para el conductor exterior:
	es_conductor(:, 0) = .TRUE.
  es_conductor(:, N) = .TRUE.
  es_conductor(0, :) = .TRUE.
  es_conductor(N, :) = .TRUE.

	V(:, 0) = V1
  V(:, N) = V1
  V(0, :) = V1
  V(N, :) = V1

  !! Para el conductor interior:
	!!! Asumimos que el número de nodos es un múltiplo de 5.
	N25 = INT((2.d0/5.d0)*N)
	N35 = INT((3.d0/5.d0)*N)

	es_conductor(N25: N35, N35) = .TRUE.
  es_conductor(N25: N35, N25) = .TRUE.
  es_conductor(N25, N25: N35) = .TRUE.
  es_conductor(N35, N25: N35) = .TRUE.

	V(N25: N35, N35) = V2
  V(N25: N35, N25) = V2
  V(N25, N25: N35) = V2
  V(N35, N25: N35) = V2
END SUBROUTINE red_inicial

SUBROUTINE Poisson(N, eps, es_conductor, V)
  implicit none
  integer,INTENT(IN)::N
  real(8),INTENT(IN)::eps
	real(8),dimension(0:N, 0:N),INTENT(INOUT)::V
  logical,dimension(0:N, 0:N),INTENT(IN)::es_conductor

  integer::i, j, iconteo
  real(8)::V_ij, dV, err

  iconteo = 0
  do while (.TRUE.)
     err = 0.d0
     do i = 1, N-1
        do j = 1, N-1
           !cambiamos el potencial solo para no conductores
           if(.NOT.es_conductor(i,j))then
              V_ij = 0.25d0*(V(i+1,j) + V(i-1,j) + V(i,j+1) + V(i,j-1))
              dV = abs(V(i,j)-V_ij)
              if(err.lt.dV)err = dV !error maximo
              V(i,j)= V_ij
           endif
        enddo
     enddo
     iconteo = iconteo + 1
     if(err.lt.eps)exit
  enddo
  write(6,*)iconteo,' error= ',err
END SUBROUTINE Poisson

SUBROUTINE guardar(N, L1, h, V)
	IMPLICIT none
	INTEGER, INTENT(IN)::N
	REAL(8), INTENT(IN)::h, L1
	REAL(8), DIMENSION(0:N, 0:N),INTENT(IN)::V

	INTEGER::i, j
	REAL(8)::xi, yj

	if(L1.eq.25.d0 )open(1, file = 'L125.dat')
	if(L1.eq.50.d0 )open(1, file = 'L150.dat')
	if(L1.eq.100.d0)open(1, file = 'L1100.dat')
	if(L1.eq.200.d0)open(1, file = 'L1200.dat')

	do i = 0, N
		do j = 0, N
			xi = i*h
			yj = j*h

			write(1, *)xi, yj, V(i,j)
		end do
		write(1, *)''
	end do
END SUBROUTINE guardar

SUBROUTINE Q(N, L1, h, V, s, z)
	! En esta subrutina se sumarán los términos En = -dV/dr a fin de integrar
	! la densidad de carga para estimar la carga total.
	IMPLICIT none
	INTEGER,INTENT(IN)::N
	REAL(8),INTENT(IN)::L1, h
	REAL(8),DIMENSION(0:N, 0:N),INTENT(IN)::V

	! Valores de las cargas: s--L1, z--L2
	REAL(8), INTENT(OUT)::s, z

	REAL(8)::slin, slsu, sliz, slde
	REAL(8)::seii, sesi, seid, sesd
	REAL(8)::zlin, zlsu, zliz, zlde
	REAL(8)::zeii, zesi, zeid, zesd
	INTEGER::N25 , N35, i
	REAL(8),PARAMETER::PI = 3.141592653589793d0

	slin = 0; zlin = 0
	slsu = 0; zlsu = 0
	sliz = 0; zliz = 0
	slde = 0; zlde = 0

	! Para el conductor de lado L1 (referencia: s).*******************************
	! Comenzamos recorriendo la red lado por lado:
	do i = 1, N-1
		slin = slin - (V(i, 0) - V(i, 0+1))/(h*4*PI)       ! slin: s lado inferior
	  slsu = slsu - (V(i, N) - V(i, N-1))/(h*4*PI)	     ! slin: s lado superior
	  sliz = sliz - (V(0, i) - V(0+1, i))/(h*4*PI)       ! slin: s lado izquierdo
		slde = slde - (V(N, i) - V(N-1, i))/(h*4*PI)       ! slin: s lado derecho
	end do

	! Consideramos el aporte de las esquinas (en diagonal):
	seii = -(V(0, 0) - V(1, 1))/(SQRT(2.d0)*h*4*PI)      ! seii: s esq. inf. izq.
	sesi = -(V(0, N) - V(1, N-1))/(SQRT(2.d0)*h*4*PI)    ! sesi: s esq. sup. izq.
	seid = -(V(N, 0) - V(N-1, 1))/(SQRT(2.d0)*h*4*PI)    ! seid: s esq. inf. der.
	sesd = -(V(N, N) - V(N-1, N-1))/(SQRT(2.d0)*h*4*PI)  ! sesd: s esq. sup. der.

	! Sumamos todos los aportes y multiplicamos por h debido a la integral:
	s = h*(slin+slsu+sliz+slde + seii+sesi+seid+sesd)

	! Para el conductor de lado L2 (referencia: z).*******************************
	! Comenzamos recorriendo la red lado por lado:
	N25 = INT((2.d0/5.d0)*N)
	N35 = INT((3.d0/5.d0)*N)
 	do i = N25+1,N35-1
		zlin = zlin - (V(i, N25) - V(i, N25-1))/(h*4*PI)
	  zlsu = zlsu - (V(i, N35) - V(i, N35+1))/(h*4*PI)
	  zliz = zliz - (V(N25, i) - V(N25-1, i))/(h*4*PI)
		zlde = zlde - (V(N35, i) - V(N35+1, i))/(h*4*PI)
	end do

	! Consideramos el aporte de las esquinas,
	! aunque esta vez no están en diagonal:
	zeii = -(V(N25, N25) - V(N25-1, N25))/(h*4*PI)
	zesi = -(V(N25, N35) - V(N25-1, N35))/(h*4*PI)
	zeid = -(V(N35, N25) - V(N35+1, N25))/(h*4*PI)
	zesd = -(V(N35, N35) - V(N35+1, N35))/(h*4*PI)

	! Sumamos todos los aportes y multiplicamos por h debido a la integral:
	z = h*(zlin+zlsu+zliz+zlde + zeii+zesi+zeid+zesd)
END SUBROUTINE Q
