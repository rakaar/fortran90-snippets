program test
	implicit none
		
    real :: matrix(9,3)
    integer :: i , j
    open(unit=1, file="input1.xyz", action="read")
	
	do i=1,9
        read(1, *) matrix(i,1), matrix(i,2), matrix(i, 3)
  end do 
    
	close(1)


    do i=1,9
      do j = 1, 3
        write(*,*) matrix(i,j)
      end do
   end do

end program test
