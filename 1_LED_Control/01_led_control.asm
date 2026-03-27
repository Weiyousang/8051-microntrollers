 ORG     00H
        JMP     START
        ORG     32H
START:
        MOV     R0, #05          
        MOV     R1, #07         
        MOV     R2, #04
        MOV     DPTR, #LED_TABLE 
LOOP1:
        CALL    SEND_LEDCODE
        CALL    DELAY_01S         
        ; Delay time 0.1 SEC
        DJNZ    R0, LOOP1
LOOP2:
        CALL    SEND_LEDCODE
        CALL    DELAY_025S       
        ; Delay time 0.25 SEC
        DJNZ    R1, LOOP2
LOOP3:
        CALL    SEND_LEDCODE
        CALL    DELAY_05S         
        ; Delay time 0.5 SEC
        DJNZ    R2, LOOP3

MOV     R2, #04         
MOV     R1, #07         
MOV     R0, #05

LOOP4:
        CALL    SEND_LEDCODE
        CALL    DELAY_05S         
        ; Delay time 0.5 SEC
        DJNZ    R2, LOOP4

LOOP5:
        CALL    SEND_LEDCODE
        CALL    DELAY_025S       
        ; Delay time 0.25 SEC
        DJNZ    R1, LOOP5
LOOP6:
        CALL    SEND_LEDCODE
        CALL    DELAY_01S         
        ; Delay time 0.1 SEC
        DJNZ    R0, LOOP6
                JMP     START

        ; Jump to START


READ_LEDCODE:
        MOV     A,#0            ;
        MOVC    A,@A+DPTR       ; 
        RET;



SEND_LEDCODE:
        CALL    READ_LEDCODE     
        ; Read LED code
        MOV     P0, A           
        ; Send LED code to PORT-0
        INC     DPTR             
        ; Point to the next LED data
        CALL    READ_LEDCODE     
        ; Read LED code
        MOV     P1, A           
        ; Send LED code to PORT-1
        INC     DPTR             
        ; Point to the next LED data
        CALL    READ_LEDCODE     
        ; Read LED code
        MOV     P2, A           
        ; Send LED code to PORT-2
        INC     DPTR             
        ; Point to the next LED data
        CALL    READ_LEDCODE     
        ; Read LED code
        MOV     P3, A           
        ; Send LED code to PORT-3
        INC     DPTR             
        ; Point to the next LED data
        RET                     
        ; Return



DELAY_01S:
        MOV     R5, #02       
LOOP9:
        MOV     R4,#254
LOOP8:
        MOV     R3,#97
        NOP
LOOP7:
        DJNZ    R3, LOOP7       
        DJNZ    R4, LOOP8       
        DJNZ    R5, LOOP9       
        RET                     


DELAY_05S:
        MOV     R6, #5         
LOOP10:
        CALL    DELAY_01S
        DJNZ    R6, LOOP10
                RET



DELAY_025S:
        MOV     R7, #25       
LOOP11:
        CALL    DELAY_01S
        DJNZ    R7, LOOP11
                RET



LED_TABLE:               


        DB      11110000B,11110000B,11110000B,11110000B
        DB      00001111B,00001111B,00001111B,00001111B
        DB      11111111B,00000000B,00000000B,11111111B
        DB      00000000B,11111111B,11111111B,00000000B
        DB      11111111B,11111111B,11111111B,11111111B

        DB      10101010B,10101010B,10101010B,10101010B
        DB      01010101B,01010101B,01010101B,01010101B
        DB      11001100B,11001100B,11001100B,11001100B
        DB      00110011B,00110011B,00110011B,00110011B
                DB              11100011B,10001110B,00111000B,11100011B
        DB              00011100B,01110001B,11000111B,00011100B
        DB      00000000B,00000000B,00000000B,00000000B

        DB      10001000B,10001000B,10001000B,10001000B
        DB      11001100B,11001100B,11001100B,11001100B
        DB      11101110B,11101110B,11101110B,11101110B
        DB      11111111B,11111111B,11111111B,11111111B

        DB              00000000B,00000000B,00000000B,00000000B
        DB      00010001B,00010001B,00010001B,00010001B
        DB              00110011B,00110011B,00110011B,00110011B
        DB              01110111B,01110111B,01110111B,01110111B

        DB      11111111B,11111111B,11111111B,11111111B
        DB              11100011B,10001110B,00111000B,11100011B
        DB              00011100B,01110001B,11000111B,00011100B
        DB      11001100B,11001100B,11001100B,11001100B
        DB      00110011B,00110011B,00110011B,00110011B
        DB      10101010B,10101010B,10101010B,10101010B
        DB      01010101B,01010101B,01010101B,01010101B

        DB              00000000B,00000000B,00000000B,00000000B
        DB              11111111B,00000000B,00000000B,11111111B
        DB              00000000B,11111111B,11111111B,00000000B
        DB      11110000B,11110000B,11110000B,11110000B
        DB      00001111B,00001111B,00001111B,00001111B

END