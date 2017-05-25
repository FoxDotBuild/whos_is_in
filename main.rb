#!/usr/bin/env ruby
require "json"

require_relative "./pi/wifi_checker"
require_relative "./pi/report"
require_relative "./pi/my_json"

class Main
  def self.run
    # Only run it at Fox.Build.
    puts "HERE GOES NUTHIN'"
    exit unless `iwgetid -r`.include?("Fox.Build")

    list   = WifiChecker.call
    puts list
    report = Report.generate(list)

    MyJson.save(report.to_json)
  end
end
