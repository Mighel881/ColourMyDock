ARCHS = arm64 arm64e

export TARGET = iphone:clang:14.0

export PREFIX=$(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ColourMyDock

ColourMyDock_FILES = Tweak.xm
ColourMyDock_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk
