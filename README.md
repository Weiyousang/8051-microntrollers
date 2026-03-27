# 8051-microntrollers
微處理機實習專案集：包含基於 8051 (AT89S51) 的揚聲器音樂播放、七段顯示器控制與 LED 陣列控制。 | 8051 Microcontroller Practice: Music player, 7-segment display, and LED control using AT89S51.
# 8051 Microcontroller Practice Projects

## 專案簡介 (About)
[cite_start]這是微處理機實習課程的系列專案。主要使用 8051 系列微控制器（如 AT89S51）進行硬體控制與韌體開發 [cite: 137, 154]。專案涵蓋了基礎的 GPIO 控制、計時器中斷（Timer Interrupts）應用以及周邊硬體驅動，展示了對底層硬體架構的理解以及使用 C 語言與組合語言的實作能力。

## 硬體與技術棧 (Tech Stack)
* [cite_start]**微控制器 (MCU):** AT89S51 / 89C51 [cite: 137, 154]
* [cite_start]**開發語言:** C 語言 [cite: 232][cite_start]、組合語言 (Assembly) [cite: 1, 47]
* [cite_start]**周邊硬體:** LED 陣列、8Ω 0.5W 揚聲器 [cite: 37][cite_start]、七段顯示器 [cite: 152][cite_start]、按鍵開關 [cite: 168]

---

## 專案列表 (Projects Overview)

### 📁 1. 聲音產生器 (Music Player)
* [cite_start]**說明:** 使用 8051 單片機實現音樂播放功能，驗證定時器與揚聲器硬體的正常運作 [cite: 36]。
* **技術重點:**
    * [cite_start]利用 Timer 0 與 Timer 1 產生中斷，精確控制音調頻率與節拍持續時間 [cite: 39, 43, 44]。
    * [cite_start]查表法 (Lookup Table)：將音調數據寫入記憶體 (`TABLE`)，根據查表轉換對應的頻率輸出至揚聲器 [cite: 40, 42, 45]。
* [cite_start]**原始碼:** 使用組合語言撰寫 [cite: 47]。

### 📁 2. 七段顯示器控制 (7-Segment Display)
* [cite_start]**說明:** 控制七段顯示器以動態掃描的方式顯示特定的數字（學號 0106C033） [cite: 152, 153, 242]。
* **技術重點:**
    * [cite_start]使用 C 語言進行開發 (`<reg51.h>`) [cite: 232]。
    * [cite_start]利用陣列儲存七段顯示器的 16 進位顯示碼 (例如 `0x3F`, `0x06` 等) [cite: 242]。
    * [cite_start]透過軟體延遲迴圈 (Delay loop) 達到視覺暫留的顯示效果 [cite: 249, 250, 256]。

### 📁 3. LED 燈光控制 (LED Pattern Control)
* **說明:** 透過控制 I/O Port，實作不同的 LED 亮滅模式與跑馬燈效果。
* **技術重點:**
    * [cite_start]透過 P0, P1, P2, P3 輸出不同燈碼 [cite: 13, 16, 19, 22]。
    * [cite_start]使用暫存器與巢狀迴圈，實作出 0.1秒、0.25秒與0.5秒的精確延遲子程式 (`DELAY_01S`, `DELAY_025S`) [cite: 3, 4, 5]。
    * [cite_start]原始碼使用組合語言撰寫 [cite: 1, 24]。
