file = 'data_oscilador'
file2 = 'potencial'

set term pngcairo size 860,430
set termoption dash
set output "P4.png"

set border lw 2

set xlabel "{/:=14 u [Å] }"
set ylabel "{/:=14 E [eV] }"

unset key
set key box outside


set xrange [-1.38488/2: 1.38488/2]
set yrange [-0.3: 0.23]

# -0.206196  -0.206087  -0.068214  -0.061677   0.024863   0.073834   0.149424   0.230712
l1(x) = -0.206196
l2(x) = -0.206087
l3(x) = -0.068214
l4(x) = -0.061677
l5(x) = 0.024863
l6(x) = 0.073834
l7(x) = 0.149424
l8(x) = 0.230712

plot file using 1:($2+l1(0)) w l lc 1 lw 1 title 'u_1(x)',\
     l1(x) lc 1 lw 2 dt '-' t 'E_1',\
     file using 1:($3+l2(0)) w l lc 2 lw 1 title 'u_2(x)',\
     l2(x) lc 2 lw 2 dt '-' t 'E_2',\
     file using 1:($4+l3(0)) w l lc 3 lw 1 title 'u_3(x)',\
     l3(x) lc 3 lw 2 dt '-' t 'E_3',\
     file using 1:($5+l4(0)) w l lc 4 lw 1 title 'u_4(x)',\
     l4(x) lc 4 lw 2 dt '-' t 'E_4',\
     file using 1:($6+l5(0)) w l lc 5 lw 1 title 'u_5(x)',\
     l5(x) lc 5 lw 2 dt '-' t 'E_5',\
     file using 1:($7+l6(0)) w l lc 1 lw 1 title 'u_6(x)',\
     l6(x) lc 1 lw 2 dt '-' t 'E_1',\
     file using 1:($8+l7(0)) w l lc 7 lw 1 title 'u_7(x)',\
     l7(x) lc 7 lw 2 dt '-' t 'E_7',\
     file2 using 1:2 w l lc 'black' lw 2 t 'Potencial'
