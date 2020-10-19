program test
    implicit none
    real :: a(2,2), b(2,2), res(2,2)
    
    ! reading from STD INPUT
    write(*, *) "Enter the numbers of first matrix"
    read(*,*) a(1,1), a(1,2), a(2,1), a(2,2)

    write(*, *) "Enter the numbers of second matrix"
    read(*,*) b(1,1), b(1,2), b(2,1), b(2,2)

   ! multiplying the matrices
    res(1,1) = (a(1,1)*b(1,1)) + (a(1,2)*b(2,1))
    res(1,2) = (a(1,1)*b(1,2)) + (a(1,2)*b(2,2))
    res(2,1) = (a(2,1)*b(1,1)) + (a(2,2)*b(2,1))
    res(2,2) = (a(2,1)*b(1,2)) + (a(2,2)*b(2,2))

    ! writting the result in matrix fashion
    write(*,*) "the resulting matrix is"
    write(*, *) res(1,1), res(1,2)
    write(*, *) res(2,1), res(2,2)

 
end program test