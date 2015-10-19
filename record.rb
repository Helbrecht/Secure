class Record

	attr_accessor :ip
	attr_accessor :date
	attr_accessor :hostname
	attr_accessor :score
	attr_accessor :type
	attr_accessor :source

	def initialize(params = {})
		@ip = params["ip"]
		@date = params["date"]
		@hostname = params["hostname"]
		@type = params["type"]
		@source = params["source"]
		@score = 0
	end

	def to_s
		"#{@ip} #{@hostname} #{@type}"
	end

end