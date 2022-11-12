INCLUDE Irvine32.inc
TITLE Loading

.data
maxX BYTE ?												; Maximun size with respect to X
maxY BYTE ?												; Maximun size with respect to Y
CenterX BYTE ?											; Center with respect to X
CenterY BYTE ?											; Center with respect to Y
two BYTE 2												; Just a variable to divide register(s)/vaiable(s) without disturbing other registers
LoadingScreenText01 BYTE "Have you lost weight?",0
LoadingScreenText02 BYTE "Life was supposed to be great ......",0
LoadingScreenText03 BYTE "Warning: Don't set yourself on fire",0
LoadingScreenText04 BYTE "Would you prefer chicken, steak, or tofu?",0
LoadingScreenText05 BYTE "Don't you think that he bits are flowing slowly today ?",0
						
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
	
	mov ecx, 0
	.WHILE(ecx <= 100)
		mov dh, CenterY
		mov dl, CenterX
		call GotoXY
		mov eax, ecx
		call WriteDec
		mov eax, '%'
		call WriteChar
	
		.IF(ecx <= 20)
			mov eax, LENGTHOF LoadingScreenText01
			sub eax, 1
			SHR eax, 1
			mov dh, CenterY
			mov dl, CenterX
			add dh, 1
			sub dl, al
			call GotoXY
			mov edx, OFFSET LoadingScreenText01 
			mov eax, 80
		.ELSEIF(ecx <= 50)
			mov eax, LENGTHOF LoadingScreenText02
			sub eax, 1
			SHR eax, 1
			mov dh, CenterY
			mov dl, CenterX
			add dh, 1
			sub dl, al
			call GotoXY
			mov edx, OFFSET LoadingScreenText02
			mov eax, 90
		.ELSEIF(ecx <=70)
			mov eax, LENGTHOF LoadingScreenText03
			sub eax, 1
			SHR eax, 1
			mov dh, CenterY
			mov dl, CenterX
			add dh, 1
			sub dl, al
			call GotoXY
			mov edx, OFFSET LoadingScreenText03
			mov eax, 180
		.ELSEIF(ecx <=93)
			mov eax, LENGTHOF LoadingScreenText04
			sub eax, 1
			SHR eax, 1
			mov dh, CenterY
			mov dl, CenterX
			add dh, 1
			sub dl, al
			call GotoXY
			mov edx, OFFSET LoadingScreenText04
			mov eax, 150
		.ELSE
			mov eax, LENGTHOF LoadingScreenText05
			sub eax, 1
			SHR eax, 1
			mov dh, CenterY
			mov dl, CenterX
			add dh, 1
			sub dl, al
			call GotoXY
			mov edx, OFFSET LoadingScreenText05
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
