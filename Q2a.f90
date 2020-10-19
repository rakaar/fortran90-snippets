program test
    implicit none
    real :: a,b,c, delta, root1, root2
    
    ! read coefficients
    write(*,*) "Enter the coefficients"
    read(*,*) a, b, c

    ! calculate delta and roots based on its value
    delta = b**2 - 4*a*c
    if (delta >= 0) then
        root1 = (-b + (delta**0.5))/(2*a)
        root2 = (-b + (delta**0.5))/(2*a)
        write(*,*) "The roots are"
        write(*,*) root1, root2
    else
        write(*,*) "Roots are not real"
    end if

end program test