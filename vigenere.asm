%include "io.mac"


section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

xor eax, eax
xor ebx, ebx
xor ecx, ecx
mov [ebp-4], dword 0 ; cnt key len
parcurgere_plain:
	mov [ebp-8], ecx ; salvam contorul sirului in ebp-8
	inc ecx

reluare_main:
	mov ecx, [ebp-8]
	movzx eax, byte[esi+ecx] ; parcurgem esi caracter cu caracter
	cmp eax, 97 ; verificam daca e litera mica
	jge peste_97
	cmp eax, 65 ; verificam daca e litera mare
	jge peste_65
	
reluare_parcurgere:
	mov byte[edx+ecx], al ; adaugam caracterul codificat in ciphertext
	inc ecx ; incrementam contorul
	mov [ebp-8], ecx
	mov ecx, [ebp-4]
	cmp ecx, [ebp+24]
	jge pseudoextindere
	mov [ebp-4], ecx
	jmp reluare_dupa_extindere
	
inc_litera:
	mov byte[edx+ecx], al ; adaugam caracterul codificat in ciphertext
	inc ecx ; incrementam contorul
	mov [ebp-8], ecx
	mov ecx, [ebp-4]
	inc ecx
	cmp ecx, [ebp+24]
	jge pseudoextindere
	mov [ebp-4], ecx

reluare_dupa_extindere:
	mov ecx, [ebp-8]
	cmp ecx, [ebp+16] ; trecem la urmatorul caracter (daca exista)
	jl parcurgere_plain
	jmp final
	
peste_97:
	cmp eax, 122 ; verificam limita superioara
	jle litera_mica
	jmp reluare_parcurgere
	
peste_65:
	cmp eax, 90
	jle litera_mare
	jmp reluare_parcurgere
	
litera_mica:
	mov [ebp-8], ecx ; salvam valoarea contorului mesajului in ebp-8
	mov ecx, [ebp-4] ; ne folosim de ecx si ebp-4 pentru a obtine cheia potrivita
	movzx ebx, byte[edi+ecx] ; caracter din cheie
	mov ecx, [ebp-8] ; readucem contorul pentru mesaj la forma initiala
	;PRINTF32 `ebx caracter din cheie: %c\n\x0`, ebx

	;PRINTF32 `esi caracter din mesaj: %c\n\x0`, byte[esi+ecx] ; caracter din mesaj
	sub ebx, 65 ; transformam din caracter in nr astfel A - 0, B - 1, etc.
	;PRINTF32 `ebx cheia de adunat: %d\n\x0`, ebx ; cheia de adunat
	add eax, ebx ; adunam cheia si asiguram caracterul circular
	jmp verificare_mica
	
litera_mare:
	mov [ebp-8], ecx
	mov ecx, [ebp-4]
	movzx ebx, byte[edi+ecx] ; caracter din cheie
	mov ecx, [ebp-8]
	;PRINTF32 `ebx caracter din cheie: %c\n\x0`, ebx

	;PRINTF32 `esi caracter din mesaj: %c\n\x0`, byte[esi+ecx] ; caracter din mesaj
	sub ebx, 65
	;PRINTF32 `ebx cheia de adunat: %d\n\x0`, ebx ; cheia de adunat
	add eax, ebx
	jmp verificare_mare

verificare_mica:
	cmp eax, 122
	jg while_scadere_mica
	;PRINTF32 `eax valoarea dupa criptare: %c\n\x0`, eax ; valoarea dupa criptare
	jmp inc_litera

while_scadere_mica:
	sub eax, 26
	jmp verificare_mica
	
verificare_mare:
	cmp eax, 90
	jg while_scadere_mare
	;PRINTF32 `eax valoarea dupa criptare: %c\n\x0`, eax ; valoarea dupa criptare
	jmp inc_litera

while_scadere_mare:
	sub eax, 26
	jmp verificare_mare

pseudoextindere:
	mov ecx, 0
	mov [ebp-4], ecx
	mov ecx, [ebp-8]
	jmp reluare_dupa_extindere

final:
	;PRINTF32 `%s\n\x0`, edx
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY