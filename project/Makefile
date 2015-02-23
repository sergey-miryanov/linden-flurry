BUILD=Build.xml

all: iphone iphone_armv7 iphone_arm64 iphone_sim

.PHONY: iphone
iphone:
	haxelib run hxcpp ${BUILD} -Diphoneos

iphone_armv7:
	haxelib run hxcpp ${BUILD} -Diphoneos -DHXCPP_ARMV7

iphone_arm64:
	haxelib run hxcpp ${BUILD} -Diphoneos -DHXCPP_ARM64

iphone_sim:
	haxelib run hxcpp ${BUILD} -Diphonesim

clean:
	rm -rf obj
	rm -rf ../ndll/IPhone/*
