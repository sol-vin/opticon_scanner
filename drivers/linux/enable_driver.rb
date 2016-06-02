#! /usr/bin/env ruby

#This file enables the opticon driver for Linux and adds the vendor and device id to that drivers usable devices.
#By default opticon is disabled (although it is in the linux kernel). The ScanFob unit is not registered with that driver
#Though they do work for this device.
require 'fileutils'

`modprobe opticon`
`bash -c 'echo 0x065a 0xa002 >> /sys/bus/usb-serial/drivers/opticon/new_id'`
FileUtils.cp File.dirname(__FILE__)+'/99-opticon-scanner.rules', '/lib/udev/rules.d/99-opticon-scanner.rules'
`udevadm control --reload-rules`
