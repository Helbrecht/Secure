require 'nokogiri'
require 'open-uri'
require_relative '../record'

class Alienvault

	HTML = "http://reputation.alienvault.com/reputation.generic"
	TYPES = 2
	IPS = 0
	SOURCE_SCORE = 10
	
	attr_accessor :records

	def initialize
		@records = []
	end

	def parse_sources
		text = open(HTML).read
		line_count = 0
		text.each_line do |line|
			line_count += 1
			next if line_count < 9
			info = line.split(" ")
			values = {}
			values["type"] = info[TYPES]
			values["ip"] = info[IPS]
			values["source"] = Alienvault
			@records << Record.new(values)
			break if line_count == 20
		end
	end
end