require "nokogiri"

puts Nokogiri::XML(`sudo nmap -sn -oX - 192.168.1.0/24`).css("hostname").to_a.map{|x| x["name"] }.sort.uniq
