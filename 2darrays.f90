program test
    implicit none
    real :: b(3,3)
    integer :: i,j

    do i=1,3
        do j=1,3
            b(i,j) = i + j
        end do
    end do

    do i=1,3
        do j=1,3
            write(*,*) b(i,j)
        end do
    end do

end program test