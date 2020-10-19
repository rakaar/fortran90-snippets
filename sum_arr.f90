subroutine testsum(arr, total)
    implicit none
    
    real :: arr(*) ! * indicates take the len same as array passed while calling
    real :: total 
    integer :: i

    total = 0.0
    do i=1,3
        total = total + arr(i)
    end do

end subroutine testsum