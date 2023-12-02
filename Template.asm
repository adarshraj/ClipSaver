; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; General Asm Template by Lahar 
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

.686					;Use 686 instuction set to have all inel commands
.model flat, stdcall	;Use flat memory model since we are in 32bit 
option casemap: none	;Variables and others are case sensitive

include Template.inc	;Include our files containing libraries

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; Our initialised variables will go into in this .data section
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
.data
	szAppName	db	"Clip Text Saver 1.0",0
	szFormat	db	"%s",0
	txtNum	dd	0

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; Our uninitialised variables will go into in this .data? section
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
.data?
	hInstance	HINSTANCE	?
	szBuffer	db	120	dup(?)

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; Our constant values will go onto this section
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
.const
	IDD_DLGBOX	equ	1001
	IDC_EXIT	equ	1002
	
	IDC_T1		equ	1005
	IDC_T2		equ	1006
	IDC_T3		equ	1007
	IDC_T4		equ	1008
	IDC_T5		equ	1009
	IDC_T6		equ	1010
	IDC_T7		equ	1011
	IDC_T8		equ	1012
	IDC_T9		equ	1013
	IDC_T10		equ	1014
	
	IDC_B1		equ	1025
	IDC_B2		equ	1026
	IDC_B3		equ	1027
	IDC_B4		equ	1028
	IDC_B5		equ	1029
	IDC_B6		equ	1030
	IDC_B7		equ	1031
	IDC_B8		equ	1032
	IDC_B9		equ	1033
	IDC_B10		equ	1034
	
	APP_ICON	equ	2000

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; This is the section to write our main code
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
.code

start:	
	invoke GetModuleHandle, NULL
	mov hInstance, eax
	invoke InitCommonControls
	invoke DialogBoxParam, hInstance, IDD_DLGBOX, NULL, addr DlgProc, NULL
	invoke ExitProcess, NULL

DlgProc		proc	hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM


	.if uMsg == WM_INITDIALOG
		invoke SetWindowText, hWnd, addr szAppName
		invoke LoadIcon, hInstance, APP_ICON
		invoke SendMessage, hWnd, WM_SETICON, 1, eax
		invoke SetTimer, hWnd, 0,100,0
		
		bye1:
	.elseif uMsg == WM_COMMAND
		mov esi,txtNum
		mov eax, wParam
		.if eax == IDC_EXIT
			

			inc esi	
			.if esi == 1	
				invoke OpenClipboard, hWnd
				invoke GetClipboardData,CF_OEMTEXT
				invoke wsprintf, addr szBuffer, addr szFormat, eax
				invoke SetDlgItemText, hWnd, IDC_T1, addr szBuffer
				invoke CloseClipboard
			.elseif esi == 2	
				invoke OpenClipboard, hWnd
				invoke GetClipboardData,CF_OEMTEXT
				invoke wsprintf, addr szBuffer, addr szFormat, eax
				invoke SetDlgItemText, hWnd, IDC_T2, addr szBuffer
				invoke CloseClipboard
			.elseif esi == 3
				invoke OpenClipboard, hWnd
				invoke GetClipboardData,CF_OEMTEXT
				invoke wsprintf, addr szBuffer, addr szFormat, eax
				invoke SetDlgItemText, hWnd, IDC_T3, addr szBuffer
				invoke CloseClipboard
			.elseif esi == 4
				invoke OpenClipboard, hWnd
				invoke GetClipboardData,CF_OEMTEXT
				invoke wsprintf, addr szBuffer, addr szFormat, eax
				invoke SetDlgItemText, hWnd, IDC_T4, addr szBuffer
				invoke CloseClipboard
			.endif	

				cmp esi,5
				mov edi,eax
				.if edi == 0
					mov esi,1
				.else
					jmp bye1
				.endif	
		.endif
	.elseif uMsg == WM_TIMER

	.elseif uMsg == WM_CLOSE
		invoke EndDialog, hWnd, NULL
	.endif
	
	xor eax, eax				 
	Ret
DlgProc EndP

end start	
	 