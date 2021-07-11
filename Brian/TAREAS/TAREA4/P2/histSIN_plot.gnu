reset session
f  = 'histSIN.dat'
ff = 'sin.dat'

set xrange [0:1.0]
#set output "P2_A1.png"
set border lw 2

Min = 0.0 # where binning starts
Max = 1.0 # where binning ends
n   = 20     # the number of bins
width = (Max-Min)/n # binwidth; evaluates to 1.0
bin(x) = width*(floor((x-Min)/width)+0.5) + Min

sinf(x) = a*sin(x)
fit sinf(x) f via a

stats ff u 2

plot f using 1:2 with points title 'Distribución A. según sin(x)',\
		 sinf(x) title 'Ajuste a*sin(x); a = 0.9976 +/- 0.0041',\
		 ff using (bin($2)):(1./(STATS_records*width)) smooth freq with points title 'Distribución A. Uniforme'

# STATS_records es el número de puntos, width es el ancho de cada bin.
# Con eso se normaliza el histograma.
