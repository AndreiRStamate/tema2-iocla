%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY
	
xor ecx, ecx ; iterator pentru mesaj
parcurgere_plain:
	movzx eax, byte[esi+ecx] ; se extrage caracter cu caracter din plaintext 
	cmp eax, 97 ; verificam limita inferioara litera mica
	jge peste_97
	cmp eax, 65 ; verificam limita inferioara litera mare 
	jge peste_65

reluare_parcurgere:
	mov byte[edx+ecx], al ; introducem in ciphertext caracterul codificat
	inc ecx ; incrementam contorul
	cmp ecx, [ebp+20] ; conditie while
	jl parcurgere_plain
	jmp final ; exit
	
peste_97:
	cmp eax, 122 ; verificam limita superioara litera mica
	jle litera_mica
	jmp reluare_parcurgere
	
peste_65:
	cmp eax, 90 ; verificam limita superioara litera mare
	jle litera_mare
	jmp reluare_parcurgere
	
litera_mica:
	add eax, edi ; adunam cheia
	jmp verificare_mica ; 
	
litera_mare:
	add eax, edi ; adunam cheia
	jmp verificare_mare

verificare_mica:
	cmp eax, 122 ; gasim valoarea potrivita prin scaderi repetate
	jg while_scadere_mica
	jmp reluare_parcurgere

while_scadere_mica:
	sub eax, 26
	jmp verificare_mica
	
verificare_mare: 
	cmp eax, 90 ; gasim valoarea potrivita prin scaderi repetate
	jg while_scadere_mare
	jmp reluare_parcurgere

while_scadere_mare:
	sub eax, 26
	jmp verificare_mare

final:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY