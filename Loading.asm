INCLUDE Irvine32.inc
TITLE Loading

.data
maxX BYTE ?					; Maximun size with respect to X
maxY BYTE ?					; Maximun size with respect to Y
CenterX BYTE ?				; Center with respect to X
CenterY BYTE ?				; Center with respect to Y
two BYTE 2					; Just a variable to divide register(s)/vaiable(s) without disturbing other registers
LoadingScreenDelay DWORD 100d				; Delay for loading screen
LoadingScreenText01 BYTE "Collecting Data",0
LoadingScreenText02 BYTE "Organizing List(s)",0
LoadingScreenText03 BYTE "Finalizing Objects",0
LoadingScreenText04 BYTE "The bits are flowing slowly today",0
						
.code
main PROC
call ReadMyScreenDetails
call LoadingScreen
exit
main ENDP

ReadMyScreenDetails PROC
	;***********************
	; NOTES
	; MAX X = 120d or 78h & MAX Y = 29d or 1Dh
	;***********************

	;Getting max screen size & center of the screen
		mov dh, 1Dh		; Should be obtained from GetMaxXY
		mov dl, 78h		; Should be obtained from GetMaxXY

	;Saving max sizes of X & Y
		mov maxX, dl
		mov maxY, dh

	;Saving the center values into vaiables
		movzx ax, maxX
		div two
		mov CenterX, al
		movzx ax, maxY
		div two
		mov CenterY, al
	ret
ReadMyScreenDetails ENDP

LoadingScreen PROC
	;***********************
	;CAUTION:	It should be called or after any important working with register. OItherwise, it'll change registers
	;ARGUMENTS:	NONE
	;RETURN:	?
	;***********************
	
	;call Clrscr
	mov ecx, 0
	.WHILE(ecx <= 100)
		
		mov dh, CenterY
		mov dl, CenterX
		call GotoXY
		mov eax, ecx
		call WriteDec
		mov eax, '%'
		call WriteChar
		
		add dh, 1
		sub dl, 7
		call GotoXY

		mov eax, 80

		.IF(ecx <= 20)
			mov edx, OFFSET LoadingScreenText01 
		.ELSEIF(ecx <= 70)
			mov edx, OFFSET LoadingScreenText02 
		.ELSEIF(ecx <=93)
			mov edx, OFFSET LoadingScreenText03 
		.ELSE
			;add dh, 1
			sub dl, 7
			call GotoXY
			mov edx, OFFSET LoadingScreenText04; 
			mov eax, 500
		.ENDIF
		call WriteString
		add ecx, 1
		call Delay
		;call Clrscr
	.ENDW
	ret
LoadingScreen ENDP
end main