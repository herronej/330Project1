PROGRAM parser

implicit none
integer         line
character*50 word
character*50    cline
character*1 c
double precision x, y

open (unit=1, file="...", status="old") 

do line = 1, 16
    read(1, '(8x,e20.7)', END=1000, ERR=1000) x
    write (*,'(I5, ": x = ", 1pe14.7)') line, x
enddo

read(1, '(A)') cline
line = 17
write(*,*) cline

do line = 18, 100
    read(1, '(15x, f10.3,7x,e20.7)'), END=1000,ERR=1000) x, y
    write (*,'(I5, ": x = ", 1pe14.7, ", y = ",1pe14.7)') line,x,y
enddo
