program test
    implicit none
    integer :: num1, num2,i, uni_b(2), j
    real :: uni_a(6)
    character(len=10) :: cryst, atom, p,atoms(2),word_atom, end


    open(unit=1, file="input4.pdb", action="read", status="old")
    open(unit=2, file="output4.pdb", action="write", status="new")

    ! read the unique line
    read(1,*) cryst, uni_a(:), p, uni_b(:)
    write(2,"(a8,2x,3(f5.3,x),3(f5.2,x),a1,x,i1,x,i1)") cryst, uni_a(:), p, uni_b(:) 

    do i=1,878
        do j=1,13
            read(1,*) word_atom, num1, atoms(:), num2, uni_a(:5), atom
            write(2,"(a4,2x,i2,2x,a1,2x,a1,2x,i1,x,3(f6.3,x),2(f5.2,x),2x,a1)") word_atom, num1, atoms(:), num2, uni_a(:5), atom
        end do
        read(1,*) end
        write(2,*) end
    end do

end program test