program test
    implicit none
    integer :: n, num_of_primes, i, j, flag

    
    num_of_primes = 1 ! already counting 2

    write(*,*) "Enter n"
    read(*,*) n

    ! Assuming range means starting from 2 and ending at n , the set = {2,3,4... n}
    do i=3,n
        flag = 1
        do j=2,i-1
            if (mod(i,j) == 0) then !if the i has a divisor between 2 and i-1, then its not a prime
                flag = 0
                exit
            else 
                continue
            end if 
        end do
        
        if (flag == 1) then
            num_of_primes = num_of_primes + 1
        else 
            continue
        end if
    end do

    write(*,*) "number of primes are", num_of_primes
    

end program test