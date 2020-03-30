# Include
include ../../../target.mk
### 'TARGET' : Target file of compile. ###
TARGET  = libthumbprint.a
LIBSRC = Adafruit_Fingerprint.cpp 
LIBHDR = Adafruit_Fingerprint.h 

LIBOBJ = $(LIBSRC:.cpp=.o)

CPPFLAGS += -Wno-narrowing -Wwrite-strings -fpermissive
 

all: install-headers $(TARGET) install

$(TARGET): $(LIBOBJ)
	ar rcs $(TARGET) $<

$(LIBOBJ): $(LIBSRC)
	$(CXX) $(CPPFLAGS) -I$(MAKETOP)/inc -c $< -o $@

install: 

install-headers:
	#$(CP) $(LIBHDR) $(MAKETOP)/inc/

clean: 
	$(RM) $(TARGET)
	$(RM) *.o
	$(RM) $(MAKETOP)/inc/$(LIBHDR)
	rm -f test_remote test_local

unit_test:
	$(CXX) $(CPPFLAGS) -I$(MAKETOP)/inc unit_test.cpp libthumbprint.a -lserial -o test_remote

#unit_test:
	#$(CXX) $(CPPFLAGS) -I$(MAKETOP)/thirdparty/c-periphery/src test2.cpp libthumbprint.a $(MAKETOP)/thirdparty/c-periphery/periphery.a  -o test_remote2
	#$(CXX) $(CPPFLAGS) test2.cpp libthumbprint.a $(MAKETOP)/thirdparty/c-periphery/periphery.a  -o test_remote

unit_test_local:
	g++ -c -Wnarrowing $(LIBSRC) -o Adafruit_Fingerprint_local.o 
	ar rcs libthumbprint_local.a Adafruit_Fingerprint_local.o 
	rm -f Adafruit_Fingerprint_local.o
	g++ unit_test.cpp libthumbprint_local.a -lserialport  -o test_local
	rm -f libthumbprint_local.a
	#g++ $(CPPFLAGS) -I$(MAKETOP)/inc enroll.cpp libthumbprint.a /home/user/Work/emv_tayyab/src/mw/serial/libserialport/library/lib/libserialport.a  -o 2test_local

#g++ -Wno-narrowing -L../../serial/RS232/libserial.a -libserial  -c Adafruit_Fingerprint.cpp -o Adafruit_Fingerprint.o
make_serial:
	$(CXX) $(CPPFLAGS) -I$(MAKETOP)/inc -c myserial.cpp 
	ar rcs myserial.o libmyserial

upload:
	~/upload.sh test_remote
