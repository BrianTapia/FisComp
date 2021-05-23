file = 'data_oscilador'
file2 = 'potencial'

set xlabel "{/:=14 x [rad] }"
set ylabel "{/:=14 y}"

unset key
set key box outside

# -0.206196  -0.206087  -0.068214  -0.061677   0.024863   0.073834   0.149424   0.230712
l1(x) = -0.206196
l2(x) = -0.206087
l3(x) = -0.068214
l4(x) = -0.061677
l5(x) = 0.024863
l6(x) = 0.073834
l7(x) = 0.149424
l8(x) = 0.230712

plot file using 1:2 w l lc "red" title 'a',\
     l1(x),\
     file using 1:3 w l lc "red" title 'a',\
     l2(x),\
     file using 1:4 w l lc "red" title 'a',\
     l3(x),\
     file using 1:5 w l lc "red" title 'a',\
     l4(x),\
     file using 1:6 w l lc "red" title 'a',\
     l5(x),\
     file using 1:7 w l lc "red" title 'a',\
     l6(x),\
     file using 1:8 w l lc "red" title 'a',\
     l7(x),\
     file using 1:9 w l lc "red" title 'a',\
     l8(x),\
     file2 using 1:2 w l lw 2
