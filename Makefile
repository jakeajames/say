TARGET = iphone:clang:11.2:7.0
ARCHS = armv7 arm64 arm64e

include $(THEOS)/makefiles/common.mk

TOOL_NAME = say
say_FILES = main.m
say_PRIVATE_FRAMEWORKS = AppSupport
say_CODESIGN_FLAGS = -Sent.plist

include $(THEOS_MAKE_PATH)/tool.mk

SUBPROJECTS += saysb

include $(THEOS_MAKE_PATH)/aggregate.mk
