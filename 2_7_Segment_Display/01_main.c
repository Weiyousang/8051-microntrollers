#include <reg51.h>
#define LED0 P0
#define LED1 P1
#define LED2 P2
#define LED3 P3
void delay1ms(int); // 延遲函數，單位為 1 毫秒

main(){
	int i=0; // 宣告變數 i，並設定初始值為 0
	char code array_00[8]={0x3F,0x06,0x3F,0x7D,0x39,0x3F,0x4F,0x4F}; // 宣告七段顯示器顯示 0~7 的值的陣列

	while(1){ // 進入無窮迴圈
		for(i=0;i<8;i++){ // 進入 for 迴圈，i 從 0 開始遞增，直到 i 等於 8 結束迴圈
			LED1=array_00[i]; // 將 array_00[i] 的值輸出至 LED1 七段顯示器
			delay1ms(500); // 延遲 500 毫秒
			LED1=0x00; // 將 LED1 七段顯示器清空
			delay1ms(300); // 延遲 300 毫秒
		}
	}

}
void delay1ms(int a){
	int i,j;
	for(i=0;i<a;i++) // 外層迴圈，執行 a 次
		for(j=0;j<120;j++); // 內層迴圈，執行 120 次
