TARGET ?= iphone:clang:latest:10.0
ARCHS ?= arm64 arm64e
DEBUG ?= no

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = saySB
saySB_FILES = Tweak.xm
saySB_FRAMEWORKS = UIKit AVFoundation
saySB_PRIVATE_FRAMEWORKS = AppSupport

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"
