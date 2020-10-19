program test
	implicit none
	real :: a(27)	
	integer :: i

	open(unit=1, file="input1.xyz", action="read")
	
	do i=1,9
	 	read(1, *) a(3*(i-1)+ 1), a(3*(i-1)+ 2), a(3*(i-1)+ 3)
	end do 
	
	close(1)

	! testing if successfully written in array
	do i=1,27
		write(*,*) a(i)
	end do
end program test
