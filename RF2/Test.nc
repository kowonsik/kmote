configuration Test{
}
implementation{
components MainC, LedsC, TestM, ActiveMessageC;
components new AMSenderC(5);
components new AMReceiverC(5);
components HplMsp430InterruptC;
components new Msp430InterruptC() as port27i;

TestM.Boot -> MainC;
TestM.Leds -> LedsC;

TestM.AMControl -> ActiveMessageC;
TestM.AMSend -> AMSenderC;
TestM.Packet -> AMSenderC;
TestM.Receive -> AMReceiverC;
port27i.HplInterrupt -> HplMsp430InterruptC.Port27;
TestM.GpioInterrupt -> port27i;
}
