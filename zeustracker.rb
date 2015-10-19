require 'nokogiri'
require 'open-uri'

class Zeustracker

	HTML = "https://zeustracker.abuse.ch/monitor.php"
	DATES = 0
	TYPES = 1
	HOSTNAMES = 2
	IPS = 3


	attr_accessor :ips
	attr_accessor :dates
	attr_accessor :types
	attr_accessor :hostnames

	def initialize
		@ips = []
		@dates = []
		@types = []
		@hostnames = []
	end

	def parse_sources

		page = Nokogiri::HTML(open(HTML))
		table_with_data = page.css("table") [1]
		table_with_data.css("tr").each_with_index do |row,index|
			next if index == 0
			row_tds = row.css("td")
			@dates << row_tds[DATES].text
			@types << row_tds[TYPES].text
			@hostnames << row_tds[HOSTNAMES].text
			@ips << row_tds[IPS].css("a").text
		end
	end
end

