! compute the value of pi using the numerical method and compare it with pi value 
! function to integrate to get pi value 
!  f(a) = 4.d0 / (1.d0 + a*a)

program main
  implicit none      ! declare all variables explicitly 
  include 'mpif.h'   ! defines MPI functions and constants 

  real(kind=8), parameter :: PI25DT = 3.141592653589793238462643d0  ! value is fixed and its value cannot be changed during the program 
  real(kind=8) :: mypi, pi, h, sum, x, f, a  ! kind=8 means double precision. It can store a real number up to 15 numbers after the decimal point 
  integer :: n, i, ierr

  integer :: myid, numprocs    ! myid is the rank and numprocs is the total number of processes 


  call MPI_INIT(ierr)    ! MPI initialization 
  call MPI_COMM_RANK(MPI_COMM_WORLD, myid, ierr) ! Assigns the ranks to the processes and store it in myid variable
  call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)  ! get total no of processes and store it in numprocs 

  if (myid .eq. 0) then        ! rank 0 only can access the standard input 
    write(*,*) 'Enter the number of intervals: (0 quits) '
    read(*,*) n
  endif
! broadcast n to other processes - sends the data in rank 0 to all remaining processes 
    call MPI_BCAST(n, 1, MPI_INTEGER, 0, MPI_COMM_WORLD, ierr)

!  calculate the interval size
  h = 1.0d0/dble(n)    ! for integration, first determine the step size (dx in the integrator) 

  sum  = 0.0d0         ! initializing the variable 
  do i = myid+1, n, numprocs    ! here numprocs is the increament, understand how it works by uncommenting the below write statement 
    x = h * (dble(i) - 0.5d0)   ! this is part of integration scheme. Read any basic integration algorithm to find out more details 
    sum = sum + (4.d0 / (1.d0 + x*x))

!    write(*,*) ' rank ',myid,' iteration ',i 
  enddo

  mypi = h * sum      ! this provides the value after integration for each process 

! notice that the program didn't use MPI_Barrier.. Is it needed ? 

! collect all the partial sums and add them to get final integration value
  call MPI_REDUCE(mypi, pi, 1, MPI_DOUBLE_PRECISION, &
                     MPI_SUM, 0, MPI_COMM_WORLD, ierr)    ! reduce function - answer is stored in process with rank 0 

! node 0 prints the answer.
  if (myid .eq. 0) then

! here the computed value (pi) is compared against known value (PI25DT) which tells us
! how accurate is the calculation 
    write(*,*) 'pi is ', pi, ' Error is', abs(pi - PI25DT)
  endif


  call MPI_FINALIZE(ierr)    ! exit from the MPI envinronment 

end program main 
