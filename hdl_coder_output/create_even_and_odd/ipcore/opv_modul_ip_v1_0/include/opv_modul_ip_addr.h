/*
 * File Name:         /home/matt/OPV_TX_abraxas3d/create-even-and-odd-HDL/ipcore/opv_modul_ip_v1_0/include/opv_modul_ip_addr.h
 * Description:       C Header File
 * Created:           2024-04-20 21:17:07
*/

#ifndef OPV_MODUL_IP_H_
#define OPV_MODUL_IP_H_

#define  IPCore_Reset_opv_modul_ip       0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_opv_modul_ip      0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_opv_modul_ip   0x8  //contains unique IP timestamp (yymmddHHMM): 2404200401: 2404202059: 2404202116

#endif /* OPV_MODUL_IP_H_ */
