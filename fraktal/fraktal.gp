reset
unset key
unset colorbox
unset tics
#unset border
set border 0
#set nokey
#set size square 1,1
set pm3d
set view map
set hidden3d
set log cb
#set xrange [-10:-8]
#set yrange [-1:1]
#set xlabel 'x'
#set ylabel 'y'
set term png size 1920,1080
set out 'fraktal1.png'
p 'fraktal.dat' w image notitle


reset
#unset key
#set nokey
#set size square
#unset border
set pm3d at st
#set view map
set hidden3d
#set log cb
#set xrange [-10:10]
#set yrange [-10:10]
#set xlabel 'x'
#set ylabel 'y'
set term png size 1920,1080
set out 'fraktal3.png'
splot 'fraktal.dat'
