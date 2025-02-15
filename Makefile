BUILDDIR := ./build/
BINARY = $(BUILDDIR)FileBrowser

all : dir package


toolchain := $(ROOTDIR)toolchain/
CXX = $(toolchain)/bin/arm-xiaomi-linux-uclibcgnueabi-g++
CC =$(toolchain)/bin/arm-xiaomi-linux-uclibcgnueabi-gcc
LIB_DIR = -L$(ROOTDIR)lib
LD_LIBRARY_PATH = $(ROOTDIR)lib
CXXFLAGS += -I$(ROOTDIR)include/
LDFLAGS = -Wall -O2 -lxmrouter -lthrift -lssl -lcrypto -lconfig++ -ljson-c \
 -lboost_system -lboost_filesystem -lthriftnb -levent -lcurl -lz -lboost_thread \
 -lroutermain -std=c++11 -lxmrouter

dir : 
	mkdir -p $(BUILDDIR)
	#mkdir -p $(BUILDDIR)bin
	#mkdir -p $(BUILDDIR)etc


#makebinary :
#	$(CXX) $(CXXFLAGS) JSON.cpp Tools.cpp inifile.c Frp.cpp $(LIB_DIR) $(LDFLAGS) -o $(BINARY) -L $(LIB_DIR)
	
clean:
	rm -r build

.PHONY : clean TaskWatcher


mips : dir packagemips

packagemips: 
	cp start_script build/
	cp -rf bin/filebrowser_mips build/filebrowser
	cp -rf script/* build/
	cp -rf etc/* build/
	$(ROOTDIR)/plugin_packager_x64

package: 
	cp start_script build/
	cp -rf bin/filebrowser build/
	cp -rf script/* build/
	cp -rf etc/* build/
	$(ROOTDIR)/plugin_packager_x64