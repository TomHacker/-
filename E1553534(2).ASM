MYDATA SEGMENT 
DATA DW 1234H,5678H,9D4CH,0D7H,0,-1,7823H,10F5H,645DH,8A0EH,8000H,8002H
N EQU $-DATA 
JIA DW 2
YI DB 4
COUNT DW 0
FG DW 0
MIN DW 0
MESS DB 13,10,'error! no even','$'
MYDATA ENDS
STACK SEGMENT 'STACK'
DW 100 DUP(?)
STACK ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:MYDATA,SS:STACK
MAIN PROC FAR
PUSH DS
MOV AX,0
PUSH AX
MOV AX,MYDATA
MOV DS,AX
MOV CX,N
    SHR CX,1
    MOV COUNT,CX
    
    MOV AX,7FFEH
    MOV BX,OFFSET DATA
N1: TEST WORD PTR [BX],1
    JZ N2;偶数
    ADD BX,JIA
    LOOP N1 
    CALL DISP
N2: MOV FG,1;说明有偶数，否则没偶数
    CMP AX,WORD PTR [BX]
    JG N3
    ADD BX,JIA
    LOOP N1
    CALL DISP
N3: MOV AX,WORD PTR [BX]
    ADD BX,JIA
    LOOP N1  
    CALL DISP
    

DISP:
   MOV CX,4
   MOV MIN,AX
   MOV BX,AX
   CMP FG,1
   JE N4
   MOV DX,OFFSET MESS
   MOV AH,9
   INT 21H
   RET
   
N4:AND BL,0FH
   CMP BL,10
   JB NEXT1
   ADD BL,37H
   PUSH BX
   ROR AX,1
ROR AX,1
ROR AX,1
ROR AX,1
   MOV BL,AL
   LOOP N4
  JMP FIN
NEXT1:
   ADD BL,30H
   PUSH BX
   ROR AX,1
ROR AX,1
ROR AX,1
ROR AX,1
   MOV BL,AL
   LOOP N4
   JMP FIN
FIN:
   POP BX
   MOV DL,BL
   MOV AH,2
   INT 21H
  POP BX
   MOV DL,BL
   MOV AH,2
   INT 21H
  POP BX
   MOV DL,BL
   MOV AH,2
   INT 21H
  POP BX
   MOV DL,BL
   MOV AH,2
   INT 21H
   RET
 RET
MAIN ENDP
CODE ENDS
     END MAIN