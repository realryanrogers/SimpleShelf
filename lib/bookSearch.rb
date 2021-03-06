require 'httparty'
require 'cgi'

class BookSearch

    def self.search(term)
        puts "Term is: " + term
        termEncoded = CGI.escape(term)
        response = HTTParty.get('https://api2.isbndb.com/books/' + termEncoded,
            {
                headers: {
                    "Content-Type" => 'application/json',
                    "Authorization" => isbndb_secret
                }
            })
        return response
    end

    def self.decode(str)
        #this will determine the search that needs to happen. ISBN or string search
        return str
    end

    def self.isbndb_secret
        return ENV["ISBNDB_SECRET"]
    end
end