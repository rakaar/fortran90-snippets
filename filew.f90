program test
    implicit none
    integer :: i
    
    open(1, file="yo3.xyz", action="write", status="new")
    do i=1,3
        write(1,*) i
    end do

end program test