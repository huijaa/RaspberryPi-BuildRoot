QTDECLARATIVE_VERSION = 48b2d386399341307027efb151f59873c5372407
QTDECLARATIVE_SITE = git://gitorious.org/qt/qtdeclarative.git
QTDECLARATIVE_SITE_METHOD = git
QTDECLARATIVE_DEPENDENCIES = qtbase qtxmlpatterns qtjsbackend
QTDECLARATIVE_INSTALL_STAGING = YES

define QTDECLARATIVE_CONFIGURE_CMDS
	-[ -f $(@D)/Makefile ] && $(MAKE) -C $(@D) distclean
	#run qmake
	(cd $(@D) && $(HOST_DIR)/usr/bin/qmake )
endef

define QTDECLARATIVE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QTDECLARATIVE_INSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) install
endef

define QTDECLARATIVE_INSTALL_TARGET_CMDS
	cp -dpf $(STAGING_DIR)/usr/lib/libQt5Qml*.so.* $(TARGET_DIR)/usr/lib
	cp -dpf $(STAGING_DIR)/usr/lib/libQt5Quick*.so.* $(TARGET_DIR)/usr/lib
	cp -dpf $(STAGING_DIR)/usr/bin/qml* $(TARGET_DIR)/usr/bin
	cp -dpfr $(STAGING_DIR)/usr/plugins/qml* $(TARGET_DIR)/usr/plugins
	cp -dpfr $(STAGING_DIR)/usr/qml $(TARGET_DIR)/usr
endef

define QTDECLARATIVE_UNINSTALL_TARGET_CMDS
	-rm $(TARGET_DIR)/usr/lib/libQt5Qml*.so.*
	-rm $(TARGET_DIR)/usr/lib/libQt5Quick*.so.*
	-rm $(TARGET_DIR)/usr/bin/qml*
	-rm -r $(TARGET_DIR)/usr/qml
endef

$(eval $(generic-package))
