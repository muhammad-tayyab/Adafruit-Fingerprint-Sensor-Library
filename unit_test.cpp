#include "Adafruit_Fingerprint.h"
#include "libserial/SerialStream.h"
#include <stdio.h>
#include <unistd.h>

//int check(enum sp_return result);

int main()
{
    /*using namespace LibSerial;
    SerialStream hwSerial;
  hwSerial->Open("/dev/ttyAMA0");
  hwSerial->SetBaudRate(LibSerial::BaudRate::BAUD_57600);
  hwSerial->SetCharacterSize(LibSerial::CharacterSize::CHAR_SIZE_8);
  hwSerial->SetDTR(false);
  hwSerial->SetFlowControl(LibSerial::FlowControl::FLOW_CONTROL_NONE);
  hwSerial->SetParity(LibSerial::Parity::PARITY_NONE);
  hwSerial->SetStopBits(LibSerial::StopBits::STOP_BITS_1);*/
    Adafruit_Fingerprint *finger = new Adafruit_Fingerprint();
    finger->begin(57600);
    printf("verifying pass\n");
    printf("verify %d\n",finger->verifyPassword());
    return 0;
}