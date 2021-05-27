reset session
file = 'prob_u2'
file2 = 'potencial'

set term pngcairo size 860,430
set termoption dash
set output "P4B.png"

set border lw 2

set xlabel "{/:=14 u [Å] }"
set ylabel "{/:=14 E [eV] }"

unset key
set key box outside


set xrange [-1.38488/2: 1.38488/2]
set yrange [-0.3: 1.1]

c1 = -0.26139
c2 =  0.26139
set arrow from c1, graph 0 to c1, graph 1 nohead lc 'red' lw 1.5
set arrow from c2, graph 0 to c2, graph 1 nohead lc 'red' lw 1.5

# -0.206196  -0.206087  -0.068214  -0.061677   0.024863   0.073834   0.149424   0.230712
l1(x) = -0.206196

plot file using 1:2 w l lc 1 lw 1 title '|u_1|^2(x)',\
     l1(x) lc 1 lw 2 dt '-' t 'E_1',\
     file2 using 1:2 w l lc 'black' lw 2 t 'Potencial'
