DATA SEGMENT
X DB 00H; x中存数字个数
Y DB 00H; Y中村字母个数
Z DB 00H; 其他
C10 DB 10
MESS1 DB 13,10,'Please input:','$'
MESS2 DB 13,10,'Number:','$'
MESS3 DB 13,10,'Charecter:','$'
MESS4 DB 13,10,'Other:','$'
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA

START:
MOV AX, DATA
MOV DS, AX
MOV DX,OFFSET MESS1
MOV AH,09H
INT 21H

N1:
MOV AH,1
INT 21H
CMP AL,0DH;  比较是不是回车键
JZ N2
CMP AL,30H
JB OTHER1;低于48就什么都不是了
CMP AL,3AH;  58分水岭，小于58就是数字了 无符号数，JB,JA就可以了。
JB NUMBER1
CMP AL,65
JB OTHER1
CMP AL,91
JB CHAR1
CMP AL,97
JB OTHER1
CMP AL,123
JB CHAR1
JMP OTHER1

NUMBER1:
  INC X
  JMP N1
CHAR1:
   INC Y
   JMP N1
OTHER1:
   INC Z
   JMP N1
N2:
   
   MOV DX, OFFSET MESS2
   MOV AH,9
   INT 21H
   MOV CX,2
   MOV AL,X
ONE:  MOV AH,0 
      DIV C10
      PUSH AX
      LOOP ONE
      MOV CX,2
TWO: POP DX
     XCHG DH,DL
   OR DL,30H
   MOV AH,2
   INT 21H
   LOOP TWO

   MOV DX, OFFSET MESS3
   MOV AH,9
   INT 21H
   MOV CX,2
   MOV AL,Y
THREE:  MOV AH,0 
      DIV C10
      PUSH AX
      LOOP THREE
      MOV CX,2
F: POP DX
     XCHG DH,DL
   OR DL,30H
   MOV AH,2
   INT 21H
   LOOP F
   
   MOV DX, OFFSET MESS4
   MOV AH,9
   INT 21H
   MOV CX,2
   MOV AL,Z
ZE:  MOV AH,0 
      DIV C10
      PUSH AX
      LOOP ZE
      MOV CX,2
M: POP DX
     XCHG DH,DL
   OR DL,30H
   MOV AH,2
   INT 21H
   LOOP M
  
  MOV AH, 4CH
  INT 21H
CODE ENDS
   END START
