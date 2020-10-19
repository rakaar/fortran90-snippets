program test
    integer :: val
    open(1, file="not_there.xyz", action="read", status="old", iostat=val)
    close(1)
    
    if (val > 0) then
        write(*,*) "file does not exists"
    else if (val == 0) then
        write(*,*) "file exsits"
    end if

end program test