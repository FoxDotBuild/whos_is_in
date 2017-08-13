require "json"
require "nokogiri"
class WifiChecker
    MEMBER_LIST       = "./directory.json"
    IGNORE_LIST       = "./ignore.json"
    MEMBER_DIRECTORY  = JSON.parse(File.read(MEMBER_LIST))
    HIDDEN            = JSON.parse(File.read(IGNORE_LIST))

    # Runs a wifi scan on the local machine
    # returns an array of strings (names)
    def self.call
      # `nmap 192.168.1.0/24 -sP -oG -`
      # BEST REPORT (XML):
      # sudo nmap -sn -oX - 192.168.1.0/24
        #  .tap{ |x| /#puts#/ (x - MEMBER_DIRECTORY.keys) }
      #  Nokogiri::XML(`sudo nmap -sn -oX - 192.168.1.0/24`)
      #    .css("hostname")
      #    .to_a
      #    .map{|x| x["name"] }
      #    .tap{|x| puts x.join("\n")}
      #    .reject { |x| !!HIDDEN[x] }
      #    .tap{|x| puts x}
      #    .map{ |x| MEMBER_DIRECTORY[x] }
      #    .compact
      #    .sort
      #    .uniq - (MEMBER_DIRECTORY.keys)
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
        .sort
      end
    end
