include theos/makefiles/common.mk

TWEAK_NAME = lock_interposer
lock_interposer_FILES = Tweak.xm
lock_interposer_LIBRARIES = lockdown MobileGestalt
lock_interposer_FRAMEWORKS = Security
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
