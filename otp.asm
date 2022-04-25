%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

	xor ecx, ecx ; iterator pentru parcurgere
while:
	movzx ebx, byte[esi+ecx] ; parcurgem caracter cu caracter plaintext
	xor bl, byte[edi+ecx] ; xor intre caracter si cheie (se foloseste doar jumatate de registru)
	mov byte[edx+ecx], bl ; se scrie in ciphertext valoarea criptata
	add ecx, 1 ; incrementam contorul
	cmp ecx, [ebp+20] ; conditie while
    jl while

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY