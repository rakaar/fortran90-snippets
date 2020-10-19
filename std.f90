program test
	implicit none
	integer :: i, start_num, end_num
	real :: arr(200), total, avg,std,sigma_term
	
	!fill arr
	start_num = 1
	end_num = 200 !last number also number of terms
	do i = start_num,end_num
		arr(i) = i
	enddo
	
	! calculate avg
	total = 0.0
	do i = start_num, end_num
		total = total + arr(i)
	enddo
	
	avg = total/end_num
	
	! calculate sigma term
	sigma_term = 0.0
	do i = start_num, end_num
		sigma_term = sigma_term + ((arr(i)-avg)**2)
	enddo

	! calculate std
	std = ((sigma_term/end_num)**0.5)
	write(*,*) 'standard dev is ',std
end program test
