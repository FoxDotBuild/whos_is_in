require "pry"
require "nokogiri"
require "json"

MEMBER_LIST       = "./directory.json"
IGNORE_LIST       = "./ignore.json"
MEMBER_DIRECTORY  = JSON.parse(File.read(MEMBER_LIST))
HIDDEN            = JSON.parse(File.read(IGNORE_LIST))

Nokogiri::HTML(`curl 192.168.1.254`)
  .css("table")
  .css("tr")
  .to_a
  .map(&:to_s)
  .map    { |x| Nokogiri::XML(x) }
  .map    { |x| [x.css("td:nth-child(1)").text, x.css("td:nth-child(2)").text]}
  .select { |x| x.last === "Active" }
  .map    { |x| x.first }
  .map    { |x| MEMBER_DIRECTORY[x] }
  .compact
  .uniq
