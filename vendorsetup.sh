#
# This file is part of the OrangeFox Recovery Project
# Copyright (C) 2022 The OrangeFox Recovery Project
#
# OrangeFox is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# OrangeFox is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# This software is released under GPL version 3 or any later version.
# See <http://www.gnu.org/licenses/>.
#
#  Please maintain this if you use this script or any part of it
#

FDEVICE="onclite"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	export LC_ALL="C"
	export ALLOW_MISSING_DEPENDENCIES=true
	export TARGET_DEVICE_ALT=onclite,onc

	#Language
	export TW_DEFAULT_LANGUAGE="en"

	# Fox-specific flags
	export OF_USE_GREEN_LED=0
	export FOX_RESET_SETTINGS=1
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_NANO_EDITOR=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_ZIP_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export FOX_ENABLE_APP_MANAGER=1
	export FOX_REPLACE_BUSYBOX_PS=1
	export OF_IGNORE_LOGICAL_MOUNT_ERRORS=1
	export FOX_REPLACE_TOOLBOX_GETPROP=1
	export OF_FBE_METADATA_MOUNT_IGNORE=1

	export FOX_BUGGED_AOSP_ARB_WORKAROUND="1616300800"; # Sun 21 Mar 04:26:40 GMT 2021
	export OF_USE_SYSTEM_FINGERPRINT=1
	# run a process after formatting data to recreate /data/media/0 (only when forced-encryption is being disabled)
	export OF_RUN_POST_FORMAT_PROCESS=1

	#Addons
	export FOX_DELETE_INITD_ADDON=1 # !- Causes bootloops sometimes -!
	export FOX_DELETE_AROMAFM=1

	# LZMA compression - this is needed!
	export OF_USE_LZMA_COMPRESSION=1

	# Removes the loop block errors after flashing ZIPs (Workaround)
	export OF_LOOP_DEVICE_ERRORS_TO_LOG=1
		
	#Magiskboot
	export OF_USE_MAGISKBOOT=1
	export OF_USE_NEW_MAGISKBOOT=1
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1

	# OTA & MIUI
	# vanilla build
	export FOX_VANILLA_BUILD=1
	export OF_KEEP_DM_VERITY=1
	export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
	export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
	export OF_KEEP_DM_VERITY_FORCED_ENCRYPTION=1
	 # dispense with the entire OTA menu
	export OF_DISABLE_OTA_MENU=1
	# OTA for custom ROMs
	export OF_SUPPORT_ALL_PAYLOAD_OTA_UPDATES=1

	# screen settings
	export OF_SCREEN_H=2280
	export OF_STATUS_H=80
	export OF_STATUS_INDENT_LEFT=48
	export OF_STATUS_INDENT_RIGHT=48
	export OF_NO_SPLASH_CHANGE=1
	
	# default keymaster service version
	 export OF_DEFAULT_KEYMASTER_VERSION=4.1

    # -- add settings for R11 --
	export FOX_R11=1
	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=0
	export OF_QUICK_BACKUP_LIST="/boot;/dtbo;/data;/system_image;/vendor_image;"
	# -- end R11 settings --

	# Redmi 7/Y3 specific
	export FOX_BUILD_TYPE="Beta"
	export OF_MAINTAINER=Naze X melles1991

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
 	fi
fi
