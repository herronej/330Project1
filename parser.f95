program parser
implicit none
character :: next_char
character(len=25), dimension(26):: buf
real :: lines,sentnc,sylab,words
integer :: stat,size


lines = 0
sentnc = 0
sylab = 0
words = 0

open(7, file='translations/NIV.txt')
do while(stat/=0)
    read(7, *, iostat=stat) buf !next_char
    if(stat /= 0) exit
    !end if
    print *, buf
    !count words
    if(next_char == " ") then
        words = words + 1
    end if
    ! count sentences
    !if(next_char == )

end do

close(7)

print *,words

end program parser
