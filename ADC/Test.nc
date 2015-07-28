configuration Test{
}

implementation{

components MainC, LedsC, TestM, ActiveMessageC;
components new TimerMilliC() as Timer0;
components new AMSenderC(5);
components new AMReceiverC(5);
components new SensirionSht11C() as Sht7;

TestM.Boot -> MainC;
TestM.Leds -> LedsC;
TestM.Timer0 -> Timer0;

TestM.AMControl -> ActiveMessageC;
TestM.AMSend -> AMSenderC;
TestM.Packet -> AMSenderC;
TestM.Receive -> AMReceiverC;
//TestM.AMPacket -> AMSenderC;


TestM.Temperature -> Sht7.Temperature;
TestM.Humidity -> Sht7.Humidity;

}
