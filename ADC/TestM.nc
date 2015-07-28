module TestM{
	uses
	{ 
		interface Boot;
		interface Leds;
		interface Timer<TMilli> as Timer0;
		interface Packet;
		interface AMPacket;
		interface AMSend;
		interface Receive;
		interface SplitControl as AMControl;

		interface Read<uint16_t> as Temperature;
		interface Read<uint16_t> as Humidity;
	}
}

implementation{


	typedef nx_struct TestMsg{
		nx_uint16_t Temp;
		nx_uint16_t Humi;
	}TestMsg;

	uint16_t g_temperature;
	uint16_t g_humidity;

	message_t test;

	task void SendData(){

		TestMsg* testpkt = (TestMsg*)(call Packet.getPayload(&test, sizeof(TestMsg)));
		testpkt -> Temp = g_temperature;
		testpkt -> Humi = g_humidity;

		call AMSend.send(AM_BROADCAST_ADDR, &test, sizeof(TestMsg));

		call Leds.led0Off();
	}

	event void Boot.booted(){
		call AMControl.start();
	}

	event void AMControl.startDone(error_t error){
		call Timer0.startPeriodic(2000);
	}

	event void AMControl.stopDone(error_t error){
	}

	event void Timer0.fired(){
		call Temperature.read();
		call Leds.led0On();
	}

	event void Temperature.readDone(error_t result, uint16_t val){
		g_temperature = val;
		call Humidity.read();
	}

	event void Humidity.readDone(error_t result, uint16_t val){
		g_humidity = val;
		post SendData();
	}


	event void AMSend.sendDone(message_t* msg, error_t error){
	}

	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len){
		call Leds.led0Toggle();
		return msg;
	}

}
