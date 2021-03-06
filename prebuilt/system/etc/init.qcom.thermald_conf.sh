#!/system/bin/sh
# Copyright (c) 2012, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of Code Aurora Forum, Inc. nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#

# No path is set up at this point so we have to do it here.
PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

THERMALD_CONF_SYMLINK=/etc/thermald.conf

# symlink already exists, exit
if [ -h $THERMALD_CONF_SYMLINK ]; then
	exit 0
fi

# create symlink to target-specific config file
ver=`cat /sys/devices/system/soc/soc0/version`
platformid=`cat /sys/devices/system/soc/soc0/platform_version`
soc_id=`cat /sys/devices/system/soc/soc0/id`

case $soc_id in
     "168"  | "169"  | "170" )
             ln -s /etc/thermald-8x25q-msm2-msm_therm.conf $THERMALD_CONF_SYMLINK 2>/dev/null
;;
esac

case $soc_id in
     "127" | "128" | "129" | "137" | "167" )
if [ "$ver" = "2.0" ]; then
        case "$platformid" in
             "196608" | "65536") #PVT 1 & 2 and SKUD
             ln -s /etc/thermald-8x25-msm2-msm_therm.conf $THERMALD_CONF_SYMLINK 2>/dev/null
             ;;

             *) #ALL other variants
             ln -s /etc/thermald-8x25-msm2-pmic_therm.conf $THERMALD_CONF_SYMLINK 2>/dev/null
             ;;
        esac
elif [ "$ver" = "1.0" ]; then
	ln -s /etc/thermald-8x25-msm1-pmic_therm.conf $THERMALD_CONF_SYMLINK 2>/dev/null
fi

;;
esac
