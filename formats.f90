program test
    
    ia = 1234
    ib = 432



! formats

! use x for spaces

! integer - width of integer = num of digits
write(*, "(i4,i4)") ia, ib
write(*, "(2(i4))") ia, ib ! both are same
write(*, "(2(i4,2x))") ia, ib! 2x is space
! if the width of integer is greater than specified format it prints only stars, ex putting ib = 12345, prints ****

! real 
write(*, "(f10.3)") 123.45 !  # 3 places after decimal 
! f10 => 10 =  places_before_decimal + places_after_decimal
! exp format "e10.3"
! 3f10 => 3 numbers

! character
! a8 => 8 characters
!a5 => is equialent to a(1:6)


end program test

