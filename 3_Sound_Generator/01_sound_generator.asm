T0_COUNT EQU 50000     ; 定義常數 T0_COUNT 為 50000
SPK EQU P1.0          ; 定義常數 SPK 為 P1.0
TIMES EQU 30H         ; 定義常數 TIMES 為 30H
H_TMP EQU 31H         ; 定義常數 H_TMP 為 31H
L_TMP EQU 32H         ; 定義常數 L_TMP 為 32H

ORG 0H                ; 程式起始位置設置為 0H
JMP SETTING           ; 跳轉到 SETTING 標籤
ORG 0BH               ; 程式起始位置設置為 0BH
JMP TIMER0_INT        ; 跳轉到 TIMER0_INT 標籤
ORG 1BH               ; 程式起始位置設置為 1BH
JMP TIMER1_INT        ; 跳轉到 TIMER1_INT 標籤

SETTING:              ; SETTING 標籤
	SETB    EA          ; 啟用全域中斷
	SETB    ET0         ; 啟用定時器 0 中斷
	SETB    ET1         ; 啟用定時器 1 中斷
	MOV     SP,#70H     ; 設置堆疊指標 SP 為 70H
	MOV     TMOD,#00010001B  ; 設置定時器模式，T0 和 T1 都為 16 位元計數器模式
	MOV     TH0,#HIGH(65536-T0_COUNT)  ; 設置定時器 0 的高位元計數器初值
	MOV     TL0,#LOW(65536-T0_COUNT)   ; 設置定時器 0 的低位元計數器初值
	MOV     DPTR,#TABLE  ; 將資料指標 DPTR 設置為 TABLE 的位址
	MOV     R0,#0       ; 將 R0 設置為 0
	SETB    TR0         ; 啟動定時器 0

MAIN:                 ; MAIN 標籤
	MOV     A,R0       ; 將 R0 的值載入暫存器 A
	MOVC    A,@A+DPTR  ; 從 DPTR 所指的記憶體位置取出資料存入 A
	MOV     TIMES,A    ; 將 A 的值存入 TIMES 變數
	CJNE    A,#255,SOUND  ; 如果 A 不等於 255，跳轉到 SOUND 標籤
	MOV     R0,#0      ; 將 R0 設置為 0
	JMP     MAIN       ; 跳轉到 MAIN 標籤

SOUND:                ; SOUND 標籤
	CALL    READ_TONE  ; 呼叫 READ_TONE 子程序
SOUND1:               ; SOUND1 標籤
	MOV     A,TIMES    ; 將 TIMES 的值載入暫存器 A
	CJNE    A,#0,SOUND1  ; 如果 A 不等於 0，跳轉到 SOUND1 標籤
	CLR     TR1        ; 停止定時器 1
	INC     R0         ; 將 R0 的值加 1
	JMP     MAIN       ; 跳轉到 MAIN 標籤

READ_TONE:            ; READ_TONE 子程序
	INC     R0         ; 將 R0 的值加 1
	MOV     A,R0       ; 將 R0 的值載入暫存器 A
	MOVC    A,@A+DPTR  ; 從 DPTR 所指的記憶體位置取出資料存入 A
	MOV     H_TMP,A    ; 將 A 的值存入 H_TMP 變數
	MOV     TH1,H_TMP  ; 將 H_TMP 的值存入 TH1 計數器
	INC     R0         ; 將 R0 的值加 1
	MOV     A,R0       ; 將 R0 的值載入暫存器 A
	MOVC    A,@A+DPTR  ; 從 DPTR 所指的記憶體位置取出資料存入 A
	MOV     L_TMP,A    ; 將 A 的值存入 L_TMP 變數
	MOV     TL1,L_TMP  ; 將 L_TMP 的值存入 TL1 計數器
	MOV     A,H_TMP    ; 將 H_TMP 的值載入暫存器 A
	CJNE    A,#0,SPK_WORK  ; 如果 A 不等於 0，跳轉到 SPK_WORK 標籤
	CLR     TR1        ; 停止定時器 1
	RET                 ; 返回呼叫點

SPK_WORK:             ; SPK_WORK 標籤
	SETB    TR1        ; 啟動定時器 1
	RET                 ; 返回呼叫點

TIMER0_INT:           ; TIMER0_INT 標籤
	PUSH    ACC        ; 將 ACC 暫存器的值壓入堆疊
	PUSH    PSW        ; 將 PSW 暫存器的值壓入堆疊
	DEC     TIMES      ; 將 TIMES 變數減 1
	MOV     TH0,#HIGH(65536-T0_COUNT)  ; 設置定時器 0 的高位元計數器初值
	MOV     TL0,#LOW(65536-T0_COUNT)   ; 設置定時器 0 的低位元計數器初值
	SETB    TR0        ; 啟動定時器 0
	POP     PSW        ; 將堆疊中的值彈出至 PSW 暫存器
	POP     ACC        ; 將堆疊中的值彈出至 ACC 暫存器
	RETI                ; 返回中斷點

TIMER1_INT:           ; TIMER1_INT 標籤
	PUSH    ACC        ; 將 ACC 暫存器的值壓入堆疊
	PUSH    PSW        ; 將 PSW 暫存器的值壓入堆疊
	CPL     SPK        ; 反轉 SPK 位元
	MOV     TH1,H_TMP  ; 將 H_TMP 的值存入 TH1 計數器
	MOV     TL1,L_TMP  ; 將 L_TMP 的值存入 TL1 計數器
	SETB    TR1        ; 啟動定時器 1
	POP     PSW        ; 將堆疊中的值彈出至 PSW 暫存器
	POP     ACC        ; 將堆疊中的值彈出至 ACC 暫存器
	RETI                ; 返回中斷點

TABLE:                ; TABLE 標籤
	DB      30,253,54  ; 定義資料區域，這裡為音調數據
	DB      70,254,179
	DB      255
	END                 ; 程式結束
