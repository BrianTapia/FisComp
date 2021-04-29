PROGRAM p4b
	implicit none
	integer::i,N
	real(8)::prec ! Precisión.
	real(8)::t , t0, tf, h
	
	real(8)::errx, erry, errz ! Errores.
	
	real(8)::xk , yk , zk , vxk , vyk , vzk 
	real(8)::xq , yq , zq , vxq , vyq , vzq
	real(8)::xc , yc , zc , vxc , vyc , vzc 
	
	real(8)::x0, y0, z0, vx0, vy0, vz0
	
	! Auxiliares para evaluar las ODEs
	real(8)::kauxx, kauxy, kauxz, kauxvx, kauxvy, kauxvz 
	real(8)::qauxx, qauxy, qauxz, qauxvx, qauxvy, qauxvz 
	real(8)::cauxx, cauxy, cauxz, cauxvx, cauxvy, cauxvz 

	! Constantes RK4:
	real(8)::kx1, ky1, kz1, kvx1, kvy1, kvz1
	real(8)::kx2, ky2, kz2, kvx2, kvy2, kvz2
	real(8)::kx3, ky3, kz3, kvx3, kvy3, kvz3
	real(8)::kx4, ky4, kz4, kvx4, kvy4, kvz4
	
	real(8)::qx1, qy1, qz1, qvx1, qvy1, qvz1
	real(8)::qx2, qy2, qz2, qvx2, qvy2, qvz2
	real(8)::qx3, qy3, qz3, qvx3, qvy3, qvz3
	real(8)::qx4, qy4, qz4, qvx4, qvy4, qvz4
	
	real(8)::cx1, cy1, cz1, cvx1, cvy1, cvz1
	real(8)::cx2, cy2, cz2, cvx2, cvy2, cvz2
	real(8)::cx3, cy3, cz3, cvx3, cvy3, cvz3
	real(8)::cx4, cy4, cz4, cvx4, cvy4, cvz4
	
	! Condición de salida:
	logical::prec_lograda

	prec_lograda = .false. ! Seteamos la condición de salida.
	
	! Preguntamos al usuario por la precisión deseada:
	write(6,*)'Ingrese la precisión deseada:'
	read(5,*)prec
	
	! Condiciones iniciales:
	t0 = 0.d0
	
	x0  = 1.d0; y0  = 0.d0; z0  = 0.d0
	vx0 = 0.d0; vy0 = 1.d0; vz0 = 0.1d0
	
	! Pasos e intervalo de solución:
	tf = 500.d0 ! 500 segundos de simulación.
	h = 0.1d0; N = (tf - t0)/h
	
	open(1, file = 'P5B.dat', status = 'replace')
	write(1,*)t0, x0, y0, z0
	
	! Iniciamos el ciclo principal. Termina sólo cuando
	! prec_lograda = .true.
	do while(1==1)
	
	! Iniciamos el ciclo para cada intento de h:
	do i=1,N
		t = t0+h
		! --------------------------------------------------------------
		! --------------------------------------------------------------
		! Se realiza RK4 de manera normal:
		
		call edo1(y0, z0, vy0, vz0, kvx1)
		call edo2(z0, vx0, kvy1)
		call edo3(y0, vx0, kvz1)
		call edo4(vx0, kx1)
		call edo5(vy0, ky1)
		call edo6(vz0, kz1)
		
		kauxx = x0 + (h/2.d0)*kx1
		kauxy = y0 + (h/2.d0)*ky1
		kauxz = z0 + (h/2.d0)*kz1
		kauxvx = vx0 + (h/2.d0)*kvx1
		kauxvy = vy0 + (h/2.d0)*kvy1
		kauxvz = vz0 + (h/2.d0)*kvz1
		
		call edo1(kauxy, kauxz, kauxvy, kauxvz, kvx2)
		call edo2(kauxz, kauxvx, kvy2)
		call edo3(kauxy, kauxvx, kvz2)
		call edo4(kauxvx, kx2)
		call edo5(kauxvy, ky2)
		call edo6(kauxvz, kz2)
		
		kauxx = x0 + (h/2.d0)*kx2
		kauxy = y0 + (h/2.d0)*ky2
		kauxz = z0 + (h/2.d0)*kz2
		kauxvx = vx0 + (h/2.d0)*kvx2
		kauxvy = vy0 + (h/2.d0)*kvy2
		kauxvz = vz0 + (h/2.d0)*kvz2
		
		call edo1(kauxy, kauxz, kauxvy, kauxvz, kvx3)
		call edo2(kauxz, kauxvx, kvy3)
		call edo3(kauxy, kauxvx, kvz3)
		call edo4(kauxvx, kx3)
		call edo5(kauxvy, ky3)
		call edo6(kauxvz, kz3)
		
		kauxx = x0 + (h)*kx3
		kauxy = y0 + (h)*ky3
		kauxz = z0 + (h)*kz3
		kauxvx = vx0 + (h)*kvx3
		kauxvy = vy0 + (h)*kvy3
		kauxvz = vz0 + (h)*kvz3
		
		call edo1(kauxy, kauxz, kauxvy, kauxvz, kvx4)
		call edo2(kauxz, kauxvx, kvy4)
		call edo3(kauxy, kauxvx, kvz4)
		call edo4(kauxvx, kx4)
		call edo5(kauxvy, ky4)
		call edo6(kauxvz, kz4)
		
		! Valores en el punto.
		xk = x0 + (h/6.d0)*(kx1 + 2.d0*kx2 + 2.d0*kx3 + kx4)
		yk = y0 + (h/6.d0)*(ky1 + 2.d0*ky2 + 2.d0*ky3 + ky4)
		zk = z0 + (h/6.d0)*(kz1 + 2.d0*kz2 + 2.d0*kz3 + kz4)
		vxk = vx0 + (h/6.d0)*(kvx1 + 2.d0*kvx2 + 2.d0*kvx3 + kvx4)
		vyk = vy0 + (h/6.d0)*(kvy1 + 2.d0*kvy2 + 2.d0*kvy3 + kvy4)
		vzk = vz0 + (h/6.d0)*(kvz1 + 2.d0*kvz2 + 2.d0*kvz3 + kvz4)
		!---------------------------------------------------------------
		! --------------------------------------------------------------
		! Consideramos un paso de 2h:
		
		call edo1(y0, z0, vy0, vz0, qvx1)
		call edo2(z0, vx0, qvy1)
		call edo3(y0, vx0, qvz1)
		call edo4(vx0, qx1)
		call edo5(vy0, qy1)
		call edo6(vz0, qz1)
		
		qauxx = x0 + (2.d0*h/2.d0)*qx1
		qauxy = y0 + (2.d0*h/2.d0)*qy1
		qauxz = z0 + (2.d0*h/2.d0)*qz1
		qauxvx = vx0 + (2.d0*h/2.d0)*qvx1
		qauxvy = vy0 + (2.d0*h/2.d0)*qvy1
		qauxvz = vz0 + (2.d0*h/2.d0)*qvz1
		
		call edo1(qauxy, qauxz, qauxvy, qauxvz, qvx2)
		call edo2(qauxz, qauxvx, qvy2)
		call edo3(qauxy, qauxvx, qvz2)
		call edo4(qauxvx, qx2)
		call edo5(qauxvy, qy2)
		call edo6(qauxvz, qz2)
		
		qauxx = x0 + (2.d0*h/2.d0)*qx2
		qauxy = y0 + (2.d0*h/2.d0)*qy2
		qauxz = z0 + (2.d0*h/2.d0)*qz2
		qauxvx = vx0 + (2.d0*h/2.d0)*qvx2
		qauxvy = vy0 + (2.d0*h/2.d0)*qvy2
		qauxvz = vz0 + (2.d0*h/2.d0)*qvz2
		
		call edo1(qauxy, qauxz, qauxvy, qauxvz, qvx3)
		call edo2(qauxz, qauxvx, qvy3)
		call edo3(qauxy, qauxvx, qvz3)
		call edo4(qauxvx, qx3)
		call edo5(qauxvy, qy3)
		call edo6(qauxvz, qz3)
		
		qauxx = x0 + (2.d0*h)*qx3
		qauxy = y0 + (2.d0*h)*qy3
		qauxz = z0 + (2.d0*h)*qz3
		qauxvx = vx0 + (2.d0*h)*qvx3
		qauxvy = vy0 + (2.d0*h)*qvy3
		qauxvz = vz0 + (2.d0*h)*qvz3
		
		call edo1(qauxy, qauxz, qauxvy, qauxvz, qvx4)
		call edo2(qauxz, qauxvx, qvy4)
		call edo3(qauxy, qauxvx, qvz4)
		call edo4(qauxvx, qx4)
		call edo5(qauxvy, qy4)
		call edo6(qauxvz, qz4)
		
		! Valores en el punto.
		xq = x0 + (h/6.d0)*(qx1 + 2.d0*qx2 + 2.d0*qx3 + qx4)
		yq = y0 + (h/6.d0)*(qy1 + 2.d0*qy2 + 2.d0*qy3 + qy4)
		zq = z0 + (h/6.d0)*(qz1 + 2.d0*qz2 + 2.d0*qz3 + qz4)
		vxq = vx0 + (h/6.d0)*(qvx1 + 2.d0*qvx2 + 2.d0*qvx3 + qvx4)
		vyq = vy0 + (h/6.d0)*(qvy1 + 2.d0*qvy2 + 2.d0*qvy3 + qvy4)
		vzq = vz0 + (h/6.d0)*(qvz1 + 2.d0*qvz2 + 2.d0*qvz3 + qvz4)
		!---------------------------------------------------------------
		! --------------------------------------------------------------
		! Consideramos dos pasos de h:
	
		call edo1(y0, z0, vy0, vz0, cvx1)
		call edo2(z0, vx0, cvy1)
		call edo3(y0, vx0, cvz1)
		call edo4(vx0, cx1)
		call edo5(vy0, cy1)
		call edo6(vz0, cz1)
		
		cauxx = x0 + (h/2.d0)*cx1
		cauxy = y0 + (h/2.d0)*cy1
		cauxz = z0 + (h/2.d0)*cz1
		cauxvx = vx0 + (h/2.d0)*cvx1
		cauxvy = vy0 + (h/2.d0)*cvy1
		cauxvz = vz0 + (h/2.d0)*cvz1
		
		call edo1(cauxy, cauxz, cauxvy, cauxvz, cvx2)
		call edo2(cauxz, cauxvx, cvy2)
		call edo3(cauxy, cauxvx, cvz2)
		call edo4(cauxvx, cx2)
		call edo5(cauxvy, cy2)
		call edo6(cauxvz, cz2)
		
		cauxx = x0 + (h/2.d0)*cx2
		cauxy = y0 + (h/2.d0)*cy2
		cauxz = z0 + (h/2.d0)*cz2
		cauxvx = vx0 + (h/2.d0)*cvx2
		cauxvy = vy0 + (h/2.d0)*cvy2
		cauxvz = vz0 + (h/2.d0)*cvz2
		
		call edo1(cauxy, cauxz, cauxvy, cauxvz, cvx3)
		call edo2(cauxz, cauxvx, cvy3)
		call edo3(cauxy, cauxvx, cvz3)
		call edo4(cauxvx, cx3)
		call edo5(cauxvy, cy3)
		call edo6(cauxvz, cz3)
		
		cauxx = x0 + (h)*cx3
		cauxy = y0 + (h)*cy3
		cauxz = z0 + (h)*cz3
		cauxvx = vx0 + (h)*cvx3
		cauxvy = vy0 + (h)*cvy3
		cauxvz = vz0 + (h)*cvz3
		
		call edo1(cauxy, cauxz, cauxvy, cauxvz, cvx4)
		call edo2(cauxz, cauxvx, cvy4)
		call edo3(cauxy, cauxvx, cvz4)
		call edo4(cauxvx, cx4)
		call edo5(cauxvy, cy4)
		call edo6(cauxvz, cz4)
		
		! Valores en el punto.
		
		! Aquí notamos que ya no comenzamos de los valores en el nodo
		! anterior (e.g. x0, y0, ...), sino que lo hacemos desde los 
		! valores en el nodo "actual" (e.g. xk, yk, ...), que ya 
		! están calculados con un paso de h, por lo que de esta manera
		! obtenemos los dos pasos, de h cada uno, que buscábamos.
		xc = xk + (h/6.d0)*(cx1 + 2.d0*cx2 + 2.d0*cx3 + cx4)
		yc = yk + (h/6.d0)*(cy1 + 2.d0*cy2 + 2.d0*cy3 + cy4)
		zc = zk + (h/6.d0)*(cz1 + 2.d0*cz2 + 2.d0*cz3 + cz4)
		vxc = vxk + (h/6.d0)*(cvx1 + 2.d0*cvx2 + 2.d0*cvx3 + cvx4)
		vyc = vyk + (h/6.d0)*(cvy1 + 2.d0*cvy2 + 2.d0*cvy3 + cvy4)
		vzc = vzk + (h/6.d0)*(cvz1 + 2.d0*cvz2 + 2.d0*cvz3 + cvz4)
		!---------------------------------------------------------------
		! --------------------------------------------------------------
		
		! Calculamos los errores:
		errx = abs(xq - xc)/30.d0
		erry = abs(xq - xc)/30.d0
		errz = abs(xq - xc)/30.d0
		
		! Verificamos la condición de salida.
		if ((errx.le.prec).and.(erry.le.prec).and.(errz.le.prec))then
			prec_lograda = .true.
		end if
		
		write(1,*)t, xk, yk, zk
		
		t0 = t
		x0 = xk; vx0 = vxk
		y0 = yk; vy0 = vyk
		z0 = zk; vz0 = vzk
		
	end do ! Finaliza el ciclo interno.
	
	if(prec_lograda)then
		close(1)
		write(6,*)'Precisión lograda. Valor de h final: ',h
		exit
	else
		! Si después del ciclo obtenemos una precisión que no es 
		! satisfactoria, reiniciamos las condiciones iniciales y
		! disminuimos el valor de h.
		
		! Reiniciamos también el archivo:
		close(1, status = 'delete')
		! Condiciones iniciales:
		t0 = 0.d0
		
		x0  = 1.d0; y0  = 0.d0; z0  = 0.d0
		vx0 = 0.d0; vy0 = 1.d0; vz0 = 0.1d0
		
		! Pasos e intervalo de solución:
		tf = 500.d0 ! 500 segundos de simulación.
		h = h/2.d0; N = (tf - t0)/h
		
		open(1, file = 'P5B.dat', status = 'replace')
		write(1,*)t0, x0, y0, z0
	end if
	end do
		
	
END PROGRAM p4b

SUBROUTINE edo1(y, z, vy, vz, k)
	implicit none
	real(8),intent(IN)::y, z, vy, vz
	real(8),intent(OUT)::k
	
	k = vy + 0.02d0*z*vy + 0.02d0*y*vz
END SUBROUTINE edo1

SUBROUTINE edo2(z, vx, k)
	implicit none
	real(8),intent(IN)::z, vx
	real(8),intent(OUT)::k
	
	k = -vx - 0.02d0*z*vx
END SUBROUTINE edo2

SUBROUTINE edo3(y, vx, k)
	implicit none
	real(8),intent(IN)::y, vx
	real(8),intent(OUT)::k
	
	k = -0.02d0*y*vx -0.01*y
END SUBROUTINE edo3

SUBROUTINE edo4(vx, k)
	implicit none
	real(8),intent(IN)::vx
	real(8),intent(OUT)::k
	
	k = vx
END SUBROUTINE edo4

SUBROUTINE edo5(vy, k)
	implicit none
	real(8),intent(IN)::vy
	real(8),intent(OUT)::k
	
	k = vy
END SUBROUTINE edo5

SUBROUTINE edo6(vz, k)
	implicit none
	real(8),intent(IN)::vz
	real(8),intent(OUT)::k
	
	k = vz
END SUBROUTINE edo6
