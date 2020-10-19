program test
    implicit none
    real :: a,b,c

    write(*,*) "enter a b c"
    read(*,*) a,b,c

    call quadroots(a,b,c)
 

end program test
