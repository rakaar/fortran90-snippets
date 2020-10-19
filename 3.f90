program test
    implicit none
    integer :: num,i, rem
    real :: x, y, z
    character(len=10) :: atom

    open(unit=1, file="input3.xyz", action="read", status="old")
    open(unit=2, file="output3.xyz", action="write", status="new")

    do i=1,13170
        rem = mod(i,15)
        if (rem == 1) then
            read(1, *) num
            write(2, *) num
        else if(rem == 2) then
            read(1, *) num
            write(2, *) num
        else
            read(1, *) atom, x, y, z
            write(2, *) atom, x, y, z
        end if
    end do

    close(1)
    close(2)

end program test