program test
    real, allocatable :: coord(:,:)
    integer :: n,m
    
    n = 10
    m = 20

    allocate(coord(n,m))

    deallocate(coord)
    
end program test