program largest
	implicit none
	integer :: x,y,z
	x = 1
	y = 2
	z = 3
	
	if (x > y .and. x > z) then
		write(*,*) "x is largest"
	else if(y > z .and. y > x) then
		write(*,*) "y is largest"
	else
		write(*,*) "z is largest"
	end if

end program largest

