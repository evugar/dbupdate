appname := dbupdate

CXX := g++ -g
CXXFLAGS := 
#-std=c++11
INCLUDES := 
# -I/home/pi/lib/mosquitto/lib  -I/home/pi/lib/mosquitto/lib/cpp
LDLIBS := -lmosquitto -lmysqlclient
#LDFLAGS := -L/usr/lib 


srcfiles := $(shell find . -name "*.cpp")
objects  := $(patsubst %.cpp, %.o, $(srcfiles))

extsrcfiles :=
# /home/pi/lib/mosquitto/lib/cpp/mosquittopp.cpp
extobjects  := 
#$(notdir $(patsubst %.cpp, %.o, $(extsrcfiles)))


.SUFFIXES:

all: $(appname)

$(appname): $(objects)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $(appname) $(objects) $(extobjects)  $(LDLIBS) 

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES)  -c $<

depend: .depend

.depend: $(srcfiles) $(extsrcfiles)
	rm -f ./.depend
	$(CXX) $(CXXFLAGS) -MM $^>>./.depend;

clean:
	rm -f $(objects)

dist-clean: clean
	rm -f *~ .depend

include .depend

