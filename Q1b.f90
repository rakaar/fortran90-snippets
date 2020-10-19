program test
    implicit none
    integer :: i,n
    real :: sum, random_num

    sum = 0.0
    
    ! read value of n
    write(*,*) "Enter number of random numbers generated"
    read(*, *) n

    !generate n random numbers
    write(*,*) "The random numbers generated are "
    do i=1,n
        random_num = rand()
        write(*,*) random_num
        sum =  sum + random_num
    enddo

    ! print out the average
    write(*,*) "The average is "
    write(*,*) sum/n

end program test
