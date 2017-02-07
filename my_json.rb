require "net/http"

# Simple wrapper class to keep all the MyJSON stuff in one place.
class MyJson
    REMOTE = URI("http://api.myjson.com/bins/190kzb")

    def self.save(data)
        req = Net::HTTP::Put.new(REMOTE.path, "Content-Type" => "application/json")
        req.body = data
        res = Net::HTTP.new(REMOTE.host, REMOTE.port).request(req)
        puts res.body
    end
end