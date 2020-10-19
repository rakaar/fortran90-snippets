# MPI Important Subroutines

### MPI_Bcast - Sending to all process
```
MPI_Bcast(
   
   variable,    --- Variable(arr/variable) u are sending
 
    count,      --- (Integer) Num of things of below Type

    MPI_Datatype, --- (MPI_Int, MPI_Real)

    process_rank,  --- rank of process who is broadcasting  

    MPI_Comm communicator, ---Communicator(Mostly MPI_COMM_WORLD)

    ierr               --- in case of error 
)
```

### MPI_Reduce - All Process send to one process
```
MPI_Reduce(
    send_data, --- variable u r sending 

    recv_data, --- data to which it is being received

    count, --- (Integer) Num of things of below Type

    MPI_Datatype datatype, ---(MPI_Int, MPI_Real)

    MPI_Operation, ---MPI_Sum to add up the numbers

    process_rank, ---process rank to which data is being sent

    MPI_Comm communicator, ---Communicator(Mostly MPI_COMM_WORLD)

    ierr   ------ in case of error 
)
```

### MPI_Send - Point 2 point communication - blocking nature
```
MPI_Send(
    data,   --- variable u r sending

    count,  ---(Integer) Num of things of below Type

    MPI_Datatype datatype, ------(MPI_Int, MPI_Real)

    rank of destination,

    tag, --- Integer 

    MPI_Comm communicator ---Communicator(Mostly MPI_COMM_WORLD),

    ierr - in case of error
)
```

### MPI_Recv - pt 2 pt - blocking nature - almost same as above
```
MPI_Recv(
    data,

    count,

    MPI_Datatype,

    source,   --- Integer: Rank of Source process

    tag,      --- Integer or MPI_Any_Tag

    MPI_Comm communicator,

    MPI_Status ---MPI_Status_Ignore wild card,

    ierr
)

```

### Pt 2 Pt communication - non blocking nature
#### MPI_ISend
```
 MPI_ISend(
     variable,
     
     count,
     
     MPI_Datatype,
     
     rank of destination,
     
     tag,
     
     MPI_COMM_WORLD,
     
     request, ----integer array of size:MPI_Status_Size
     
     ierr
)
```

#### MPI_IRecv
```
MPI_IRecv(
    data,
    
    count,
    
    MPI_Datatype, 
    
    source,

    tag,

    MPI_Communicator,

    request1, ---integer array of size:MPI_Status_Size
    
    ierr
)
```

### MPI - dividing 100 tasks into np process
`num` : total number of things for example 1 -> 100 numbers then num is 100

`first_num_of_sequence`: 1 for above example, or if calculating primes and checking from 3 then 3 would be first_num_of_sequence
1. Simplest option
```
do i = first_num_of_sequnce + rank, num, nproc
   ! do something
enddo
```

2. Dividing based on strides
```
stride = num/nproc
first = rank*stride + first_num_of_sequence
last = first + stride - 1
do i = first, last
   ! do something
enddo

if (rank == nproc - 1) then
   last = num
endif
```

