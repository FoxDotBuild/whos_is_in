#!/usr/bin/env ruby
require "json"

require_relative "./wifi_checker"
require_relative "./report"
require_relative "./my_json"

# Only run it at Fox.Build.
exit unless `iwgetid -r`.include?("Fox.Build")

list   = WifiChecker.call
report = Report.generate(list)

MyJson.save(report.to_json)
