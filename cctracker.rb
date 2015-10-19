require 'nokogiri'
require 'open-uri'
require_relative 'record'

class Cctracker

	HTML = "http://cybercrime-tracker.net"
	DATES = 0
	TYPES = 3
	HOSTNAMES = 1
	IPS = 2

	SOURCE_SCORE = 10

	attr_accessor :records
	attr_accessor :html
	
	def initialize
		@records = []
		@skip = 0
		@mass = 100
		@html = "#{HTML}/index.php?#{URI.encode_www_form({"s"=>@skip,"m"=>@mass})}"
	end

	def get_more
		#formatted_skip = URI.encode_www_form(  )
		#@skip += 100
		#return formatted_skip
	end

	def reset_counter
		@skip = 0
	end

	def parse_sources
		page = Nokogiri::HTML(open(html))
		table_with_data = page.css("table").first
		table_with_data.css("tr").each_with_index do |row,index|
			next if index == 0
			row_tds = row.css("td")
			values = {}
			values["date"] = row_tds[DATES].text
			values["type"] = row_tds[TYPES].text
			values["hostname"] = row_tds[HOSTNAMES].text
			values["ip"] = row_tds[IPS].css("a").text
			values["source"] = Cctracker
			@records << Record.new(values)
		end
	end


end