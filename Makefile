TARGET ?= iphone:clang:13.0:10.0
ARCHS ?= arm64 arm64e
DEBUG ?= no

include $(THEOS)/makefiles/common.mk

TOOL_NAME = say
say_FILES = main.m
say_PRIVATE_FRAMEWORKS = AppSupport
include $(THEOS_MAKE_PATH)/tool.mk
SUBPROJECTS += saysb
include $(THEOS_MAKE_PATH)/aggregate.mk
