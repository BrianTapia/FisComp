#simulacion 2D

set macros
set size square
set title font ",20"

t0 = t0 + dt 
command = "awk -v t=".sprintf("%f",t0)." '$1<t{print $2}' ".file."|tail -n 1"
x0 = `@command`
command = "awk -v t=".sprintf("%f",t0)." '$1<t{print $3}' ".file."|tail -n 1"
y0 = `@command`
set  arrow 1 from 0,0 to x0,y0
set title "t= ".sprintf("%f (x,y)=(%f,%f)",t0,x0,y0)
plot file using 2:($1<= t0 ? $3: 1/0) with lines notitle
pause 0.1
if(t0<tf) reread

reset