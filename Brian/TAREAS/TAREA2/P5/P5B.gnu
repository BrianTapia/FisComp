file = 'P5B.dat'
set border lw 2

set title  "{/:=14 Precisión: 1e-9. Final h = 1.25e-2. }"

set xlabel "{/:=14 x }"
set ylabel "{/:=14 y }"
set zlabel "{/:=14 z }"


splot file using 2:3:4 w l title 'Trayectoria' lc 2
