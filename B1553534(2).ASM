DATA SEGMENT
A DB 40H
B DB 30H
C DB 20H
D DB 10H
S DW ?
Z DW 0005H
W DW 0002H
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:MOV AX ,DATA
      MOV DS, AX
      MOV AL, A
      IMUL B  ;�˻�����AX
      CWD; (DX AX)�õ�a*b
      MOV CX,AX;ax->cx
      MOV AL,C
      CBW;c��չ
      MOV BX,AX;BX��c��չ
      MOV AL,D
      CBW
      ADD BL,AL
      ADC BH,AH;c+d 16λ
      MOV AX,CX
      IDIV BX;(A*B)/(C+D) ����AX��������DX
      MOV CX,AX;��һ�����16λ����CX
      MOV AL,A
      CBW 
      MOV BX,AX
      MOV AL,B
      CBW
      SUB BL,AL
      SBB BH,AH;A-B ����BX��
      MOV AX,Z
      IMUL BX;5*(A-B��->(DX,AX)
      IDIV W;5*(A-B)/2->����AX��������DX
      CWD;  ������չ32λ��DX,AX)
      MOV BX,AX;�ڶ�����λ�������BX
      MOV AX,CX
      MOV CX,DX;�ڶ�������ǣ�CX,BX)
      CWD;��һ������ǣ�DX,AX)
      ADD BX,AX
      ADC CX,DX;(ǰ��������ǣ�CX,BX))
      MOV AL,C
      CBW
      IDIV D
      CBW
      CWD
      ADD AX,BX
      ADC DX,CX
      MOV S,AX
      MOV AX, 4C00H
      INT 21H
 CODE ENDS
      END START