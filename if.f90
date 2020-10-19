program ifelse
	implicit none
	integer :: x,y
	x = 1
	y = 2
	if (x < y) then
		write(*,*) x,"<",y
	else if (x > y) then
		write(*,*) x,">",y
	else
		write(*,*) x,"is",y
	end if

end program ifelse
