file = 'freep2.dat'
t0 = 0
tf = 10
dt = 0.1
set xrange [-30:30]
set yrange [-1:15]
set tics font ",15"
set xlabel "{/:=14 x (m)}"
set ylabel "{/:=14 y (m)}"

n = system(sprintf('cat %s | wc -l', file))

do for [j=1:n] {
    set title 'Iteración '.j
    pause 0.05
    plot file u 1:3 every ::1::j w l lc 'red' lw 2 title 'Trayectoria', \
         file u 1:3 every ::j::j w p lc 'black' pt 7 ps 3 title 'Partícula'
}
