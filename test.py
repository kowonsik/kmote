#!/usr/bin/python

import serial
import sys

test = serial.Serial("/dev/ttyUSB0", 115200)
tmpPkt = []
flag = 0

'''
def analysis(packet):
	print packet
	print packet[0:2]   # 7e
	print packet[2:4]   # 45
	print packet[4:6]   # 00 
	print packet[6:8]   # ff
	print packet[8:10]   # ff
	print packet[10:12]   # 00
	print 'nodeid : ' + packet[12:14]   # 07
	print packet[14:16]   # 04
	print packet[16:18]   # 00
	print 'type : ' + packet[18:20]   # 05
	print packet[20:22]   # 1b
	print packet[22:24]   # 06
	print packet[24:26]   # 08
	print packet[26:28]   # 6d
	print packet[28:30]   # 22
	print packet[30:32]   # 68

	temperature = (int(packet[20:22],16)*256 + int(packet[22:24],16))

	v1 = -39.6 + 0.01*temperature

	print 'temperature : ' + str(v1)
'''

while 1 : 
	Data_in = test.read().encode('hex')

	if(Data_in == '7e'):
		if(flag == 2):
			flag = 0
			tmpPkt.append(Data_in)
			packet = ''.join(tmpPkt)

			#analysis(packet)
			print packet

			tmpPkt = []
			sys.stdout.flush()
		else:
			flag = flag + 1
			tmpPkt.append(Data_in)
	else:
		if(flag == 1 and Data_in =='45'):
			flag = 2
		tmpPkt.append(Data_in)

