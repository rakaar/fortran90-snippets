program test
    real :: a(3), total

    a(1) = 1
    a(2) = 2
    a(3) = 3

    call testsum(a, total)

    write(*,*) total

end program test
