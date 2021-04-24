!1990, 1994, 1998
!18  , 8.7 , 10

PROGRAM writedoc
	implicit none
	
	integer::i
	integer,allocatable::yrs(:)
	real(8),allocatable::pct(:)
	
	allocate(yrs(3))
	yrs(1)=1990
	yrs(2)=1994
	yrs(3)=1998
	
	allocate(pct(3))
	pct(1)=18.d0
	pct(2)=8.7d0
	pct(3)=10.d0
	
	open(1,file='table.dat',status='unknown')
	
	do i=1,3
		write(1,"(i4,1x,F4.1)")yrs(i),pct(i)
	enddo

	close(1)
	deallocate(yrs,pct)
	
END PROGRAM writedoc
