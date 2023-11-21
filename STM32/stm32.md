创建工程：

选择芯片型号  —> 关闭创建助手 —> 添加启动的文件 —> 点击魔术棒-c/c++-include path-添加文件夹然后确定

![image-20230323230739121](C:\Users\Insummer\Desktop\markdown\STM32\startfile.png)



Delay函数

```c
/**
  * @brief  微秒级延时
  * @param  xus 延时时长，范围：0~233015
  * @retval 无
  */
void Delay_us(uint32_t xus)
{
	SysTick->LOAD = 72 * xus;				//设置定时器重装值
	SysTick->VAL = 0x00;					//清空当前计数值
	SysTick->CTRL = 0x00000005;				//设置时钟源为HCLK，启动定时器
	while(!(SysTick->CTRL & 0x00010000));	//等待计数到0
	SysTick->CTRL = 0x00000004;				//关闭定时器
}
/**
  * @brief  毫秒级延时
  * @param  xms 延时时长，范围：0~4294967295
  * @retval 无
  */
void Delay_ms(uint32_t xms)
{
	while(xms--)
	{
		Delay_us(1000);
	}
}
/**
  * @brief  秒级延时
  * @param  xs 延时时长，范围：0~4294967295
  * @retval 无
  */
void Delay_s(uint32_t xs)
{
	while(xs--)
	{
		Delay_ms(1000);
	}
} 
```

```
GPIO初始化:
RCC_APB2PriphClockCmd(RCC_APB2Periph_GPIOA,ENABLE);
GPIO_InitTypeDef GPIO_InitStructure;
GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
							//GPIO的模式，例如上拉下拉
							GPIO_Mode_AIN = 0x0,		//模拟输入
						  	GPIO_Mode_IN_FLOATING = 0x04,//浮空输入
  							GPIO_Mode_IPD = 0x28,		//下拉输入
  							GPIO_Mode_IPU = 0x48,		//上拉输入
  							GPIO_Mode_Out_OD = 0x14,	//开漏输入
  							GPIO_Mode_Out_PP = 0x10,	//推挽输入
  							GPIO_Mode_AF_OD = 0x1C,		//复用开漏输入
  							GPIO_Mode_AF_PP = 0x18		//复用推挽输入
GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0;
							//GPIO的pin脚
GPIO_InitStructure.GPIO_Speed_50Hz;
							//设置端口的反转速率
GPIO_Init(GPIOA,&GPIO_InitStructure);
```

![](C:\Users\Insummer\Desktop\markdown\STM32\GPIO_MOD.png)

在 STM32 中选用 IO 模式

+ 浮空输入_IN_FLOATING ——浮空输入，可以做 KEY 识别，RX1

+ 带上拉输入_IPU——IO 内部上拉电阻输入

+ 带下拉输入_IPD—— IO 内部下拉电阻输入

+ 模拟输入_AIN ——应用 ADC 模拟输入，或者低功耗下省电

+ 开漏输出_OUT_OD ——IO 输出 0 接 GND，IO 输出 1，悬空，需要外接上拉电阻，才能实现输出 高电平。当输出为 1 时，IO 口的状态由上拉电阻拉高电平，但由于是开漏输出模式，这样 IO 口也就可以 由外部电路改变为低电平或不变。可以读 IO 输入电平变化，实现 C51 的 IO 双向功能

+ 推挽输出_OUT_PP ——IO 输出 0-接 GND， IO 输出 1 -接 VCC，读输入值是未知的

+ 复用功能的推挽输出_AF_PP ——片内外设功能（I2C 的 SCL,SDA）

+ 复用功能的开漏输出_AF_OD——片内外设功能（TX1,MOSI,MISO.SCK.SS）

+  STM32 设置实例：

  + 模拟 I2C 使用开漏输出_OUT_OD，接上拉电阻，能够正确输出 0 和 1；读值时先 GPIO_SetBits(GPIOB, GPIO_Pin_0)；拉高，然后可以读 IO 的值；使用 GPIO_ReadInputDataBit(GPIOB,GPIO_Pin_0)；

  + 如果是无上拉电阻，IO 默认是高电平；需要读取 IO 的值，可以使用带上拉输入_IPU 和浮空输入 _IN_FLOATING 和开漏输出_OUT_OD；

+ 通常有 5 种方式使用某个引脚功能，它们的配置方式如下：

  + 作为普通 GPIO 输入：根据需要配置该引脚为浮空输入、带弱上拉输入或带弱下拉输入，同时不要使能 该引脚对应的所有复用功能模块。

  + 作为普通 GPIO 输出：根据需要配置该引脚为推挽输出或开漏输出，同时不要使能该引脚对应的所有复 用功能模块。

  + 作为普通模拟输入：配置该引脚为模拟输入模式，同时不要使能该引脚对应的所有复用功能模块。

  + 作为内置外设的输入：根据需要配置该引脚为浮空输入、带弱上拉输入或带弱下拉输入，同时使能该引 脚对应的某个复用功能模块。

  + 作为内置外设的输出：根据需要配置该引脚为复用推挽输出或复用开漏输出，同时使能该引脚对应的所 有复用功能模块。

    注意如果有多个复用功能模块对应同一个引脚，只能使能其中之一，其它模块保持非使能状态。

	设置为低电平，打开LED灯

```
GPIO_ResetBits(GPIOA,GPIO_Pin_0);
```

设置为高电平，关闭LED灯

```
GPIO_SetBits(GPIOA,GPIO_Pin_0);
```

GPIO_WriteBit有三个参数，前两个和GPIO_ResetBits和GPIO_SetBits是一样的，第三个参数则可以设置为Bit_RESET或者Bit_SET;

Bit_SET是设置端口值，也就是高电平；Bit_RESET是清除端口值，也就是设置为低电平



## 中断

首先配置GPIO，接着是EXTI，最后才配置NVIC

```C
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB,ENABLE);
	//开启AFIO的时钟		AFIO是一个复用引脚，当引脚有别的功能时可以实现另外的功能
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO,ENABLE);	
	
	GPIO_InitTypeDef GPIO_InitStructur;		//GPIO初始化
	EXTI_InitTypeDef EXTI_InitStructure;	//EXTI初始化
	NVIC_InitTypeDef NVIC_InitStructur;		//NVIC初始化

	GPIO_InitStructur.GPIO_Mode = GPIO_Mode_IPU;
	GPIO_InitStructur.GPIO_Pin = GPIO_Pin_14;
	GPIO_InitStructur.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOB,&GPIO_InitStructur);
	
	GPIO_EXTILineConfig(GPIO_PortSourceGPIOB,GPIO_PinSource14);		//AFIO外部中断引脚配置，配置AFIP的数据选择器
	
	//将EXTI的14线配置为中断模式，使用下降沿触发，并且开启中断
	EXTI_InitStructure.EXTI_Line = EXTI_Line14;	//指定line14为中断线，根据GPIO_Pin来选择
	EXTI_InitStructure.EXTI_LineCmd = ENABLE;	//指定中断的状态，开启或关闭
	EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;//指定中断线的模式
	EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Falling;//指定触发沿
	EXTI_Init(&EXTI_InitStructure);
	
	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);//指定中断的分组，也就是优先级
	NVIC_InitStructur.NVIC_IRQChannel = EXTI15_10_IRQn;//指定中断通道来开启或关闭，由于使用14，所以选择10-15
	NVIC_InitStructur.NVIC_IRQChannelCmd = ENABLE;	//指定中断通道使能或者失能
	NVIC_InitStructur.NVIC_IRQChannelPreemptionPriority = 1;	//指定通道的抢占优先级
	NVIC_InitStructur.NVIC_IRQChannelSubPriority = 1;			//指定通道的响应优先级
	NVIC_Init(&NVIC_InitStructur);

void EXTI15_10_IRQHandler(void)
{
	if(EXTI_GetITStatus(EXTI_Line14) == SET)
	{
		CountSensor_Count++;
		EXTI_ClearITPendingBit(EXTI_Line14);
	}
}
```





**extern**声明变量，告诉编译器文件内有这个变量，让编译器自行寻找，跨文件使用这个关键字可以避免报错。但是并不会生成新的变量，只是引用了这个变量。

输出模式比较：

| 模式   | 描述 |
| :-----: | :----: |
| 冻结 | CNT = CCR时，REF保持为原状态 |
| 匹配时置有效电平 | CNT = CCR时，REF置有效电平（只会置高/低电平一次） |
| 匹配时置无效电平 | CNT = CCR时，REF置无效电平（只会置高/低电平一次） |
| 匹配时电平翻转 |  CNT = CCR时，REF电平翻转 |
| 强制为无效电平 | CNT与CCR无效，REF强制为无效电平 |
| 强制为有效电平 | CNT与CCR无效，REF强制为有效电平 |
| PWM模式1 | 向上计数：CNT < CCR时，REF置**有效**电平，CNT >= CCR时，REF置**无效**电平<br />向下计数：CNT > CCR时，REF置**无效**电平，CNT <= CCR时，REF置**有效**电平 |
| PWM模式2 | 向上计数：CNT < CCR时，REF置**无效**电平，CNT >= CCR时，REF置**有效**电平<br />向下计数：CNT > CCR时，REF**有效**电平，CNT <= CCR时，REF置**无效**电平 |

```c
	RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM2,ENABLE);
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
	
	
	GPIO_InitTypeDef GPIO_InitStructure;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;	//复用推挽输出
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_2;		//GPIO_Pin_2;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA,&GPIO_InitStructure);
	
	
	TIM_InternalClockConfig(TIM2);
	TIM_TimeBaseInitTypeDef TIM_TimeBaseInitStructure;
	TIM_TimeBaseInitStructure.TIM_ClockDivision = TIM_CKD_DIV1;
	TIM_TimeBaseInitStructure.TIM_CounterMode = TIM_CounterMode_Up;
	TIM_TimeBaseInitStructure.TIM_Period = 100 - 1;					//ARR
	TIM_TimeBaseInitStructure.TIM_Prescaler = 36 - 1;			//PSC	   
	//电机轴被按住有蜂鸣是因为人耳能听到20-20khz的声音，改为76后就变为10khz了，再减半就为20khz
	TIM_TimeBaseInitStructure.TIM_RepetitionCounter = 0;
	TIM_TimeBaseInit(TIM2,&TIM_TimeBaseInitStructure);
	
	TIM_OCInitTypeDef TIM_OCInitStructure;
	TIM_OCStructInit(&TIM_OCInitStructure);	//将TIM结构体初始化，如果不想每个成员都赋值一遍，那么可以使用此函数先初始化，然后再更改需要的值
	TIM_OCInitStructure.TIM_OCMode =  TIM_OCMode_PWM1;
	TIM_OCInitStructure.TIM_OCPolarity = TIM_OCPolarity_High;
	TIM_OCInitStructure.TIM_OutputState = TIM_OutputState_Enable;
	TIM_OCInitStructure.TIM_Pulse = 10;					//Pulse就是CCR的值
	TIM_OC3Init(TIM2,&TIM_OCInitStructure);
	
	TIM_Cmd(TIM2,ENABLE);

void PWM_SetCompare3(uint16_t compare){
	TIM_SetCompare3(TIM2,compare);//这个函数用来输出PWM
}
```



C8T6的ADC资源：ADC1、ADC2、10个外部输入通道

ADC规则组的转换模式：

+ 单次转换，非扫描模式
+ 连续转换，非扫描模式
+ 单次转换，扫描模式
+ 连续转换，扫描模式

```c
RCC_APB2PeriphClockCmd(RCC_APB2Periph_ADC1,ENABLE);
RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA,ENABLE);

RCC_ADCCLKConfig(RCC_PCLK2_Div6); //分频之后，ADCCLK = 72MHz / 6 = 12MHz

GPIO_InitTypeDef GPIO_InitStructure;
GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AIN;			//配置为模拟输入
GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0;
GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
GPIO_Init(GPIOA,&GPIO_InitStructure);

ADC_RegularChannelConfig(ADC1,ADC_Channel_0,1,ADC_SampleTime_55Cycles5);	//配置ADCx、ADC通道、在序列中排第几、ADCCLK采样周期，周期越长采样越稳定
ADC_InitTypeDef ADC_InitStructure;
ADC_InitStructure.ADC_ContinuousConvMode = DISABLE;//是否连续扫描
ADC_InitStructure.ADC_DataAlign = ADC_DataAlign_Right;//右对齐
ADC_InitStructure.ADC_ExternalTrigConv = ADC_ExternalTrigConv_None;
ADC_InitStructure.ADC_Mode = ADC_Mode_Independent;
ADC_InitStructure.ADC_NbrOfChannel = 1;
ADC_InitStructure.ADC_ScanConvMode = DISABLE;					//ADC整体结构配置
ADC_Init(ADC1,&ADC_InitStructure);

ADC_Cmd(ADC1,ENABLE);

//ADC校准
ADC_ResetCalibration(ADC1);
while(ADC_GetResetCalibrationStatus(ADC1) == SET);		//等待复为完成
ADC_StartCalibration(ADC1);
while(ADC_GetCalibrationStatus(ADC1) == SET);

uint16_t AD_GetValue(void){
	ADC_SoftwareStartConvCmd(ADC1,ENABLE);//设置ADC转换开始的触发条件是软件触发
	while(ADC_GetFlagStatus(ADC1,ADC_FLAG_EOC) == RESET);
	return ADC_GetConversionValue(ADC1);
}
```

AD转换的步骤：采样、保持、量化、编码

ADC的总转换时间：	 Tconv = 采样时间 + 12.5个ADC周期

## DMA

直接存储器存储，可以提供外设和存储器或者存储器和存储器之间的高速数据传输，无需CPU干预，节省了CPU资源

| 类型 |   起始地址   | 存储器 | 用途 |
| :----: | :----: |  :----: | :----: |
| ROM | 0x0800 0000<br/>0x1FFF F000<br/>0x1FFF F800 |程序存储器Flash<br/>系统存储器<br/>选项字节|存储C语言编译后的程序代码<br/>存储BootLoader，用于串口下载<br/>存储一些独立于程序代码的配置参数|
| RAM |0x2000 0000<br/>0x4000 0000<br/>0xE000 0000|运行内存SRAM<br/>外设寄存器<br/>内核外设寄存器|存储运行过程中的临时变量<br/>存储各个外设的配置参数<br/>存储内核各个外设的配置参数|

当出现错误时，如果出现上面**起始地址**的地址代码，那么就能确定是这个存储器的问题

```C
void AD_Init(void){
	
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_ADC1,ENABLE);
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA,ENABLE);
	RCC_AHBPeriphClockCmd(RCC_AHBPeriph_DMA1,ENABLE);
	
	RCC_ADCCLKConfig(RCC_PCLK2_Div6);		//分频之后，ADCCLK = 72MHz /6 = 12MHz
	
	GPIO_InitTypeDef GPIO_InitStructure;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AIN;	//配置为模拟输入		
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0 | GPIO_Pin_1;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA,&GPIO_InitStructure);
	
	ADC_RegularChannelConfig(ADC1,ADC_Channel_0,1,ADC_SampleTime_55Cycles5);	//配置ADCx、ADC通道、在序列中排第几、ADCCLK的采样周期，越长越数据稳定，越短越快
	ADC_RegularChannelConfig(ADC1,ADC_Channel_1,2,ADC_SampleTime_55Cycles5);	
	ADC_RegularChannelConfig(ADC1,ADC_Channel_2,3,ADC_SampleTime_55Cycles5);	
	ADC_RegularChannelConfig(ADC1,ADC_Channel_3,4,ADC_SampleTime_55Cycles5);	

	
	ADC_InitTypeDef ADC_InitStructure;
	ADC_InitStructure.ADC_ContinuousConvMode = ENABLE;		//设置ENABLE为则为循环传输		
	ADC_InitStructure.ADC_DataAlign = ADC_DataAlign_Right;
	ADC_InitStructure.ADC_ExternalTrigConv = ADC_ExternalTrigConv_None;
	ADC_InitStructure.ADC_Mode = ADC_Mode_Independent;
	ADC_InitStructure.ADC_NbrOfChannel = 4;
	ADC_InitStructure.ADC_ScanConvMode = ENABLE;	//ADC整体结构配置				
	ADC_Init(ADC1,&ADC_InitStructure);
	
		
			//外设站点的3个参数
	DMA_InitTypeDef DMA_InitStructure;
	DMA_InitStructure.DMA_PeripheralBaseAddr = (uint32_t)&ADC1->DR;		//取地址，也等于4001 244C
	DMA_InitStructure.DMA_PeripheralDataSize = DMA_PeripheralDataSize_HalfWord;
	DMA_InitStructure.DMA_PeripheralInc = DMA_PeripheralInc_Disable;						
			//寄存器站点的3个参数
	DMA_InitStructure.DMA_MemoryBaseAddr = (uint32_t)AD_Value;
	DMA_InitStructure.DMA_MemoryDataSize = DMA_MemoryDataSize_HalfWord;
	DMA_InitStructure.DMA_MemoryInc = DMA_MemoryInc_Enable;
			//传输方向
	DMA_InitStructure.DMA_DIR = DMA_DIR_PeripheralSRC;
			//传输次数
	DMA_InitStructure.DMA_BufferSize = 4;
			//使用软件触发，所以使用ENABLE
	DMA_InitStructure.DMA_M2M = DMA_M2M_Disable;
			//指定传输计数器是否要重装
	DMA_InitStructure.DMA_Mode = DMA_Mode_Circular;						
    		//指定优先级
	DMA_InitStructure.DMA_Priority = DMA_Priority_Medium;
	DMA_Init(DMA1_Channel1,&DMA_InitStructure);
	
	DMA_Cmd(DMA1_Channel1,ENABLE);		//如果参数为ENABLE，那么DMA在主函数初始化后将会自动运行
    
	
	ADC_DMACmd(ADC1,ENABLE);		//等待ADC启动后才进行DMA操作	
	
	ADC_Cmd(ADC1,ENABLE);
	
		//ADC校准
	ADC_ResetCalibration(ADC1);
	while(ADC_GetResetCalibrationStatus(ADC1) == SET);		//等待复位完成
	ADC_StartCalibration(ADC1);
	while(ADC_GetCalibrationStatus(ADC1) == SET);
	ADC_SoftwareStartConvCmd(ADC1,ENABLE);	//这句
}

void AD_GetValue(void){
	DMA_Cmd(DMA1_Channel1,DISABLE);
	DMA_SetCurrDataCounter(DMA1_Channel1,4);
	DMA_Cmd(DMA1_Channel1,ENABLE);
	//ADC_SoftwareStartConvCmd(ADC1,ENABLE);//把初始化的最后一句删除，打开这一句那么就是单次传输。在初始化函数最后写这一句就是循环传输
	
	while(DMA_GetFlagStatus(DMA1_FLAG_TC1) == RESET);
	DMA_ClearFlag(DMA1_FLAG_TC1);
}
```



## UART

| 名称 | 引脚 | 双工 | 时钟 | 电平 | 设备 |
| :----: | :----: | :----: | :----: | :----: | :----: |
| USART | TX、RX | 全双工 | 异步 | 单端 | 点对点 |
| I2C | SCL、SDA | 半双工 | 同步 | 单端 | 多设备 |
| SPI | SCLK、MOS、MISO、CS | 全双工 | 同步 | 单端 | 多设备 |
| CAN | CAN_H、CAN_L | 半双工 | 异步 | 差分 | 多设备 |
| USB | DP、DM | 半双工 | 异步 | 差分 | 点对点 |

电平标准：

+ TTL：+3.3V和+5V表示1，0V表示0
+ RS323：-3V~-15V表示1，+3V~+15V表示0**（一般用于大型机器，由于环境恶劣干扰大，所以电平波动允许比较大）**
+ RS485：两线压差+2V~+6V表示1，-2V~-6V表示0，差分信号**（差分信号抗干扰很强）**

```c
uint8_t Serial_RxData;
uint8_t Serial_RxFlag;

void Serial_Init(void){
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_USART1, ENABLE);
	GPIO_InitTypeDef GPIO_InitStructure;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA,&GPIO_InitStructure);
	
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA,&GPIO_InitStructure);
	
	USART_InitTypeDef USART_InitStructure;				//初始化USART串口
	USART_InitStructure.USART_BaudRate = 9600;
	USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
	USART_InitStructure.USART_Mode = USART_Mode_Tx | USART_Mode_Rx;
	USART_InitStructure.USART_Parity = USART_Parity_No;
	USART_InitStructure.USART_StopBits = USART_StopBits_1;
	USART_InitStructure.USART_WordLength = USART_WordLength_9b;
	USART_Init(USART1,&USART_InitStructure);
	
	//开启中断的方法
	USART_ITConfig(USART1,USART_IT_RXNE,ENABLE);	//开启RXNE标志位到NVIC的输出
	//配置NVIC
	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);
	NVIC_InitTypeDef NVIC_InitStructure;
	NVIC_InitStructure.NVIC_IRQChannel = USART1_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
	NVIC_Init(&NVIC_InitStructure);
	
	USART_Cmd(USART1,ENABLE);
	
}

void Serial_SendByte(uint8_t byte){
	USART_SendData(USART1,byte);
	while(USART_GetFlagStatus(USART1,USART_FLAG_TXE) == RESET);
}

void Serial_SendArray(uint8_t *array,uint16_t length){
	uint16_t i;
	for(i = 0;i<length;i++){
		Serial_SendByte(array[i]); 
	}
}

void Serial_SendString(char* string){
	uint8_t i;
	for(i = 0; string[i] != 0;i++){
		Serial_SendByte(string[i]);
	}
}

uint32_t Serial_Pow(uint32_t x,uint32_t y){
	uint32_t result = 1;
	while(y--){
		result *= x;
	}
	return result;
}

void Serial_SendNum(uint32_t Number,uint8_t length){
	uint8_t i;
	for(i = 0 ; i < length;i++){
		Serial_SendByte(Number / Serial_Pow(10,length - i - 1) % 10 + '0');
	}
}

int fputc(int ch ,FILE *f){
	Serial_SendByte(ch);
	return ch;
}

void Serial_Printf(char * format, ...){
	char string[100];
	va_list arg;
	va_start(arg,format);
	vsprintf(string,format,arg);
	va_end(arg);
	Serial_SendString(string);
}

uint8_t Serial_GetRxFlag(void){
	if(Serial_RxFlag == 1){
		Serial_RxFlag = 0;
		return 1;
	}
	return 0;
}

uint8_t Serial_GetRxData(void){
	return Serial_RxData;
}

void USART1_IRQHandler(void){				//中断函数
	if(USART_GetITStatus(USART1,USART_IT_RXNE) == SET){
		Serial_RxData = USART_ReceiveData(USART1);
		Serial_RxFlag = 1;
		USART_ClearITPendingBit(USART1,USART_IT_RXNE);
	}
}
```

