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
       Nokogiri::XML(`sudo nmap -sn -oX - 192.168.1.0/24`)
         .css("hostname")
         .to_a
         .map{|x| x["name"] }
         .reject { |x| !!HIDDEN[x] }
         .tap{ |x| /#puts#/ (x - MEMBER_DIRECTORY.keys) }
         .map{ |x| MEMBER_DIRECTORY[x] }
         .compact
         .sort
         .uniq - (MEMBER_DIRECTORY.keys)
    end
end
