puts `nmap 192.168.1.0/24 -sL -oG -`
       .split("\n")
       .map{ |x| x[/\(.*?\)/] }
       .map{ |x| (x || "").gsub("(", "").gsub(")", "") }
       .compact
       .reject { |x| !!HIDDEN[x] }
       .tap{ |x| /#puts#/ (x - MEMBER_DIRECTORY.keys) }
       .map{ |x| MEMBER_DIRECTORY[x] }
       .compact
       .sort
       .uniq - (MEMBER_DIRECTORY.keys)
