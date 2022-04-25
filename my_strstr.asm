%include "io.mac"

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

xor eax, eax ; iterator sir haystack
xor ecx, ecx ; caracter haystack
xor edx, edx ; caracter needle
parcugere_fan:
	xor edi, edi ; iterator pentru sir needle

	movzx ecx, byte[esi+eax] ; caracterul curent din haystack 
	movzx edx, byte[ebx+0] ; primul caracter din needle
	
	cmp ecx, edx ; verificam daca sunt egale si incercam verificarea urmatoarelor
	je parcurgere_ac	
	
	inc eax
	cmp eax, [ebp + 20]
	jl parcugere_fan

parcurgere_ac:
	add edi, eax ; adunam iteratorul pentru haystack la needle
	movzx ecx, byte[esi+edi] ; haystack [i+j]
	sub edi, eax
	movzx edx, byte[ebx+edi] ; needle [j]
	
	cmp ecx, edx ; probam caracter cu caracter
	jne verificare
	
	inc edi ; conditie final sir needle 
	cmp edi, [ebp + 24]
	je parcurgere_ac
	
verificare:
	inc edi
	cmp edi, [ebp + 24] ; daca se parcurge tot sirul needle atunci am gasit subsirul
	jne valid
	jmp parcugere_fan

valid:
	mov ebx, [ebp+8] 
	mov [ebx], eax ; scriere in adresa lui edi / [ebp+8] din cerinta problemei

final:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY








