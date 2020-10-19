subroutine quadroots(a,b,c)
    implicit none
    
    real :: a,b,c,root1,root2,delta
    
    delta = b**2 - 4*a*c
    if (delta >= 0) then
        root1 = (-b + (delta**0.5))/(2*a)
        root2 = (-b + (delta**0.5))/(2*a)
        write(*,*) "The roots are"
        write(*,*) root1, root2
    else
        write(*,*) "Roots are not real"
    end if

end subroutine quadroots