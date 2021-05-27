reset session
file1 = 'efield.dat'
file2 = 'potencial.dat'
set border lw 2
set size square
set term png size 860,860
set output "ELC_2.png"


set ylabel "{/:=14 y [cm]}"
set xlabel "{/:=14 x [cm]}"

set xrange [-40:40]
set yrange [-40:40]

# Paleta input 1:
# set palette defined (-1 'white', 0 'red', 1 'black')

# Paleta input 2:
set palette defined (-1 'black', -0.50 'red', 0.50 'white', 1 'black')
set cblabel "{/:=14 symln(V) [N cm C^{-1}] }"
set cbrange [-30:30]
#plot file2 u 2:1:(log($3)) with image t '',\
#		 file1 u 2:1:4:3 every 17:17 with vector lc 'blue' lw 1.1 t ''
plot file2 u 2:1:($3 > 0 ? log($3) :-log(abs($3))) with image t '',\
  	 file1 u 2:1:4:3 every 17:17 with vector lc 'blue' lw 1.3 t ''
