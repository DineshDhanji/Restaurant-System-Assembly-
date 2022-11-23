INCLUDE Irvine32.inc
INCLUDE macros.inc
BUFFER_SIZE = 5000
TotalItems = 24

.data
buffer BYTE BUFFER_SIZE DUP(?)
filename BYTE "menu.txt", 0
fileHandle HANDLE ?

item1 BYTE "Chicken Biryani", 0
item2 BYTE "Beef Biryani", 0
item3 BYTE "Chicken Karahi", 0
item4 BYTE "Mutton Karahi", 0
item5 BYTE "White Karahi", 0
item6 BYTE "Chicken Haleem", 0
item7 BYTE "Chicken Tikka", 0
item8 BYTE "Naan", 0
item9 BYTE "Chapati", 0
item10 BYTE "Egg Fried Rice", 0
item11 BYTE "Chicken Macaroni", 0
item12 BYTE "Chicken Manchurian", 0
item13 BYTE "Zinger Burger", 0
item14 BYTE "Chicken Pizza", 0
item15 BYTE "Chicken Shawarma", 0
item16 BYTE "French Fries", 0
item17 BYTE "Coca Cola", 0
item18 BYTE "Sprite", 0
item19 BYTE "Pine Apple Juice", 0
item20 BYTE "Banana Milkshake", 0
item21 BYTE "Chocolate Cake", 0
item22 BYTE "Coconut Cream Pie", 0
item23 BYTE "Apple Pie", 0
item24 BYTE "Vanilla Icecream", 0
items DWORD item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, item14, item15, item16, item17, item18, item19, item20, item21, item22, item23, item24
price DWORD 100, 150, 600, 900, 1000, 100, 100, 15, 10, 150, 300, 300,  200, 100, 800, 200, 100, 100, 100, 80, 60, 1000, 600, 300, 200

row BYTE 1 
col BYTE 65

count BYTE 0

str1 BYTE "Enter -1 when your order is complete", 0
str2 BYTE "Enter Item Number to place your order: ", 0
str3 BYTE "		Total Bill:		", 0
str4 BYTE "			BILL DETAIL", 0

Order SWORD TotalItems DUP(-1)

.code
main PROC

call PrintMenu
call GetOrder
call RemoveEndingLines
exit
main ENDP

GetOrder PROC
LOCAL i_row : BYTE
LOCAL i_col : BYTE

	mov dh, row
	mov dl, col
	call Gotoxy
	mov edx, OFFSET str4
	call WriteString

	inc col
	inc row
	
	mov dh, row
	mov dl, col
	call Gotoxy

	mov esi, 0
	mov ecx, 52
	PrintingDash:
		mov eax, '-'
		call WriteChar
	loop PrintingDash

	inc row





	mov dh, row
	mov dl, col
	call Gotoxy
	mov edx, OFFSET str1
	call WriteString

	inc row
	mov dh, row
	mov dl, col
	call Gotoxy
	mov edx, OFFSET str2
	call WriteString

	mov al, row
	mov i_row, al
	add col, 39
	mov dl, col
	mov i_col, dl
	sub col, 39

	mov esi, 0
	Breakk:
	mov ax, 1
	.WHILE(ax != -1 && ax != 0 && ax < 25)
		mov dh, i_row
		mov dl, i_col
		call gotoxy
		call ReadInt
		.IF(eax == 0 || eax > 24)
			jmp Breakk
		.ENDIF
		mov Order[esi * TYPE WORD], ax
		inc row
		mov dh, row
		mov dl, col
		call Gotoxy
		call WriteDec
		add col, 5
		mov dh, row
		mov dl, col
		call Gotoxy
		movzx eax, Order[esi * TYPE WORD]
		dec eax
		mov edx, items[eax* TYPE DWORD]
		call WriteString
		sub col, 5
		inc esi
		mov ax, 1
	.ENDW

	ret
GetOrder ENDP

PrintMenu PROC
	pushad
	mov edx,OFFSET filename
	call OpenInputFile
	mov fileHandle,eax

	; Read the file into a buffer.
	mov edx,OFFSET buffer
	mov ecx,BUFFER_SIZE
	call ReadFromFile
	mov buffer[eax],0 

	; Display the buffer.
	mov edx,OFFSET buffer 
	call WriteString
	call Crlf
	mov eax,fileHandle
	call CloseFile
	popad
	ret
PrintMenu ENDP


; Move the cursor at the end of the screen. 
RemoveEndingLines PROC
	mov dh, 44
	mov dl, 1
	call Gotoxy
	ret
RemoveEndingLines ENDP

END main
