module TestM{
	uses
	{ 
		interface Boot;
		interface Leds;
		interface Packet;
		interface AMPacket;
		interface AMSend;
		interface Receive;
		interface SplitControl as AMControl;
		interface GpioInterrupt;
	}
}

implementation{


	typedef nx_struct TestMsg{
		nx_uint16_t nodeid;
	}TestMsg;

	message_t test;

	event void Boot.booted(){
		call AMControl.start();
		call GpioInterrupt.disable();
		call GpioInterrupt.enableFallingEdge();
	}

	event void AMControl.startDone(error_t error){
	}

	event void AMControl.stopDone(error_t error){
	}

	async event void GpioInterrupt.fired(){
		TestMsg* testpkt = (TestMsg*)(call Packet.getPayload(&test, NULL));
		testpkt -> nodeid = TOS_NODE_ID;

		call Leds.led1Toggle();
		call AMSend.send(AM_BROADCAST_ADDR, &test, sizeof(TestMsg));
	}


	event void AMSend.sendDone(message_t* msg, error_t error){
	}

	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len){
		call Leds.led0Toggle();
		return msg;
	}

}
