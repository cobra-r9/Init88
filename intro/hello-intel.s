# this will be a comment in assembly. 
# we need to use the intel syntax which has no % prefix for the registers. 
.intel_syntax noprefix 
# this will tell the assembler to follow the intel syntax 
# also in intel syntax, there is no $ on immediates, operand syntax is mov dst, src 

# we need the data section
.section .data
# but we do have the rodata : readonly section. 
.section .rodata 
msg:
    .ascii "Hello Intel assembly.!\n"
    len = . - msg 

# the executable code section 
.section .text
.globl _start
_start:
# mov 1 to rax : 1 implies write syscall  : rax is register a expanded.
# rax consists of the return value and syscall number. 
# syscall 1 = write 
    mov rax, 1
    mov rdi, 1
# first argument of the write(fd, const string, bytes) : the file descriptor 1 = stdout. 
    lea rsi, [rip + msg]
# this is somewhat different. we use the register : instruction pointer (rip) and provide the address of our msg relative to rip. 
# lea means : load effective address. 
# that is : load the effective address of msg relative to rip into rsi. 
# the second arguments of a function go into rsi. That is register source index. rdi is the register destinatoin index. 
# essentially, we are setting the destination index : 1; stdout. 
# then we are setting the source index : tell the assembler to load the effective address of the msg in rodata. (that is lea instruction.)
# that lea is done wrt rip's address.
    mov rdx, len
    syscall

# exit syscall. 
    mov rax, 60
    mov rdi, 0
    syscall 
# step 1 : assemble with assembler to object file : .o
# link it with the ld and run. 
