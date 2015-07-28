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
	}
}

implementation{


	typedef nx_struct TestMsg{
		nx_uint16_t nodeid;
	}TestMsg;

	message_t test;

	event void Boot.booted(){
		call AMControl.start();
	}

	event void AMControl.startDone(error_t error){
		if(error==SUCCESS){
			call Timer0.startPeriodic(1000);
		}else{
			call AMControl.start();
		}
	}

	event void AMControl.stopDone(error_t error){
	}

	event void Timer0.fired(){
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
