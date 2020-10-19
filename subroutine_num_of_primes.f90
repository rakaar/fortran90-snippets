subroutine num_of_primes(start_num,end_num,n)
    implicit none
    
    integer :: start_num,end_num,n
    integer :: i,flag ! for looping
    
    n = 0
    do i=start_num,end_num
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
            n = n + 1
        else 
            continue
        end if
    end do

end subroutine num_of_primes