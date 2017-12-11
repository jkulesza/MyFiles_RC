module test
  implicit none

contains
  subroutine test1()
    write(*,'(a)') "Output from test1"
  end subroutine test1
  subroutine test2()
    write(*,'(a)') "Output from test2"
  end subroutine test2
end module test

program TestProgram
  use test
  write(*,'(a)') "Hello, world"
  call test1()
  call test2()
end program TestProgram

