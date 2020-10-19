program test
    integer:: i, iters,index, score
    real :: nums(10000),new_num,old_num
    
    open(unit=1, file="random_numbers.dat", action="read", status="old")
    do i=1,10000
        read(1,*) nums(i)
    enddo
    close(1)
    
    iters = 0
    do
        score = 0
        do index=2,9999
            old_num = nums(index)
            new_num = (old_num + nums(index-1) + nums(index+1))/3.0  
            nums(index) = new_num
            if (abs(new_num - old_num) < 0.01) then
                score = score + 1
            endif
        enddo
        iters = iters + 1
        if (score == 9998) then
            write(*,*)"number of iters",iters,"score",score
            exit
        endif
        

    enddo
end program test