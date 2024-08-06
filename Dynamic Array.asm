;;; Author: Lawrence Menegus
;;; File: DynamicArray.asm
;;; Date: 3/29/23
;;; Description: Ask user for integers, add them to array, and find the number of elements, sum, max, and min of the array values.

    %define ARRAY_SIZE 10
    %define ELEMENT_SIZE 4
    %define EOF -1
    
    section .data
    Prompt: db "Please enter integer data (ctrl-d to stop): ", 0
    intformat: db "%d", 0
    Elements: db "number of elements: %d", 10, 0
    Sum: db "Sum: %d", 10, 0
    Min: db "Min: %d", 10, 0
    Max: db "Max: %d", 10, 0
    newline: db 10, 0
    
    section .bss
    Array: resq 1
    Input: resd 1
    
    section .text
    global asm_main
    extern printf, scanf, calloc
    
    asm_main:
        enter 0, 0
    
        ;; Clearing Registers
        xor rax, rax
        xor r9, r9
        xor r12, r12
        xor r13, r13
    
        ;; Allocate memory for the array
        mov rdi, ARRAY_SIZE
        mov rsi, ELEMENT_SIZE
        call calloc
        mov [Array], rax
    
        ;; Setup for user input loop
        mov rdi, [Array]
        mov rcx, ARRAY_SIZE
    
        Inputloop:
            ;; Display prompt to user
            push rcx
            push rdi
            mov rdi, Prompt
            call printf
    
            ;; Read input from user
            mov rdi, intformat
            mov rsi, Input
            call scanf
    
            ;; Check if end of input
            cmp eax, EOF
            je inDone
    
            ;; Increment element count
            inc r12
    
            ;; Store the input in the array
            ;; Update the sum and number of elements
            mov rdi, [Input]
            xor rax, rax
            mov eax, ARRAY_SIZE
            mov bx, 4
            sub eax, 1
            mul bx
            add rdi, rax
    
            ;; Check if array bounds exceeded
            cmp r12, ARRAY_SIZE
            jle skipResize
    
        resizeArray:
            xor rax, rax
            mov rdi, ARRAY_SIZE
            mov rsi, ELEMENT_SIZE
            call calloc
            mov [Array], rax
            mov rdi, [Array]
            mov rcx, ARRAY_SIZE
            cld
    
        skipResize:
            ;; Sum values
            add r13, [Input]
    
            ;; Add elements to array and loop
            xor rax, rax
            mov rax, [Input]
            pop rdi
            stosd
            mov r10, [rdi - 4]
            pop rcx
            jmp Inputloop
    
        inDone:
            ;; Find the minimum and maximum elements in the array
            mov rbx, [Array]
            mov rcx, r12
            cld
    
            ;; Initialize min and max
            xor r14, r14
            xor r15, r15
            movsx r14, DWORD [rbx]
            movsx r15, DWORD [rbx]
    
        minMaxLoop:
            push rcx
            push rsi
            xor r9, r9
    
            ;; Comparisons for Minimum
            movsx r9, DWORD [rbx]
            sub r9, r14
            jns updateMin
            movsx r14, DWORD [rbx]
    
        updateMin:
            movsx r9, DWORD [rbx]
            sub r9, r15
            js updateMax
            movsx r15, DWORD [rbx]
    
        updateMax:
            pop rsi
            pop rcx
            add rbx, 4
            loop minMaxLoop
            jmp print
    
        ;; Print the number of elements, sum, minimum and maximum
        print:
            mov rdi, newline
            call printf
            mov rdi, Elements
            mov rsi, r12
            call printf
            mov rdi, Sum
            mov rsi, r13
            call printf
            mov rdi, Min
            mov rsi, r14
            call printf
            mov rdi, Max
            mov rsi, r15
            call printf
    
        exit:
            mov rax, 0
            leave
            ret
    