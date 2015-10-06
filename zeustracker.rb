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
			# get_ips(row)
			# get_dates(row)
			# get_types(row)
			# get_hostnames(row)
			row_tds = row.css("td")
			@dates << row_tds[DATES].text
			@types << row_tds[TYPES].text
			@hostnames << row_tds[HOSTNAMES].text
			@ips << row_tds[IPS].css("a").text
		end
	end

# 	def get_ips(row)
# #		table_with_ips.css("tr").each_with_index do |row,index|
# #			next if index == 0
# #			columns = row.css("td")
# #			ip_cell = columns [3]
# #			ip_data = ip_cell.css("a").text
# #			@ips << ip_data
# #		end
# 		ip_data = row.css("td")[3].css("a").text
# 		@ips << ip_data
		
#   #       File.open("table.html", "w") do |f|
# 		# 	f.write(table_with_ips)
# 		# end
# 	end

# 	def get_dates(row)
# 		dates_data = row.css("td")[0].text
# 		@dates << dates_data
# 	end

# 	def get_types(row)
# 		types_data = row.css("td")[1].text
# 		@types << types_data
# 	end

# 	def get_hostnames(row)
# 		hostnames_data = row.css("td")[2].text
# 		@hostnames << hostnames_data
# 	end

	def print_as_table
		dates.each_with_index do |date,index|
			puts "#{date}  #{@hostnames[index]}  #{@ips[index]}   #{@types[index]}"
		end
	end
end

