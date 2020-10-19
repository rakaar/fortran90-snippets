program test
    implicit none
    ! gfortran main.f90 funcs.f90 -o main.x
    ! gfortran -c funcs.f90 # doesn't care about resolving dependencies
    ! gfortran main.o funcs.o -o main.x
    call hello

end program test

! if  u want to include the below subroutine inside the program
! add a line "contains" above the subroutine
subroutine hello
    implicit none

    write(*,*) "helo"

end subroutine hello

