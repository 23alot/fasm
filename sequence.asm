include 'INCLUDE/WIN32AX.INC' ; path to /include/

.data
msg db 256 dup ? ; output string
r dd 0d ; max length of 1 sequence
string dd 1b ; input word

.code
start:
mov ecx,0
mov eax,[r]
mov edx,0
mov ebx,[string]
L:
	cmp ecx,32
	je endloop ; end of loop check

	test ebx,1
	jz incr ; this bit is 0
	inc edx
	jmp final

	incr:
	cmp eax,edx ; compare max and temp values
	jge next
	mov eax,edx ; rewrite max value
	next: mov edx,0 ; counter to zero

	final:
	shr ebx,1
	inc ecx
	jmp L ; go to next iteration
endloop:

cmp edx,eax
jle output
mov eax,edx

mov [r],eax

output:
cinvoke wsprintf,msg,"The longest sequence of 1: %u",eax ; to string
invoke MessageBox,0,msg,"Message",MB_OK ; output ressult
invoke ExitProcess,0
.end start
