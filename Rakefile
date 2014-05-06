# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require "joybox"
require "bubble-wrap/core"

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'asteroids'
  app.interface_orientations = [:landscape_left]
  app.device_family = [:ipad]
  app.icons = ['icon.png', 'icon@2x.png']
  app.prerendered_icon = true
  
  app.codesign_certificate = 'iPhone Developer: D Oram (FHF5VEZ2YW)'
  app.provisioning_profile = '/Users/davidoram/Dropbox/provisioning/Asteriods_Test_Profile.mobileprovision'
  app.identifier = 'HWYQU39ECH.oram.dave.Asteriods'
end
