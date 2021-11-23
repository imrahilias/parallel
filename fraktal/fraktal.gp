reset
unset key
set size square
#set pm3d
#set view map
set hidden3d
set log cb
#set xrange [-10:10]
#set yrange [-10:10]
#set xlabel 'x'
#set ylabel 'y'
set term png size 1920,1080
set out 'fraktal.png'
p 'fraktal.dat' w image