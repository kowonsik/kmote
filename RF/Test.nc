configuration Test{
}

implementation{

components MainC, LedsC, TestM, ActiveMessageC;
components new TimerMilliC() as Timer0;
components new AMSenderC(5);
components new AMReceiverC(5);

TestM.Boot -> MainC;
TestM.Leds -> LedsC;

TestM.AMControl -> ActiveMessageC;
TestM.Timer0 -> Timer0;
TestM.AMSend -> AMSenderC;
TestM.Packet -> AMSenderC;
//TestM.AMPacket -> AMSenderC;
TestM.Receive -> AMReceiverC;

}
