require_relative "zeustracker"

require 'erb'

class Aggregator

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

 	def aggregate(info)
 		if  [Zeustracker,Cctracker].include? info.class 
 			load_commontracker(info)
					 		
 		end
 	
 	end


 	def get_template()
 	%{
			<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"
				 \"http://www.w3.org/TR/html4/strict.dtd\">
				<HTML>
							   
					<BODY>
						<center>
							<table border=2 width=50% >
								<tr><td>Date</td><td>Hostname</td><td>Ip</td><td>Type</td></tr>
								<% @dates.each_with_index do |date,index|%>
									<tr> <td> <%= date %> </td> <td> <%= @hostnames[index]%> </td> <td> <%= @ips[index] %> </td> <td> <%= @types[index] %> </td> </tr>
								<% end %>
							</table>
						</center>
							  
					</BODY>
				</HTML>
		}
 	end

 	def render
		ERB.new(get_template).result(binding)
	end

	def render_to_html
		Dir.mkdir("htmls") unless File.exist?("htmls")
		File.open("./htmls/Result.html", "w") do |f|
			f.write(render)
		end
	end

 	def load_commontracker(info)
 		puts info.ips.count
 		@ips += info.ips
 		@dates += info.dates
 		@types += info.types
 		@hostnames += info.hostnames
 	end

    def print_as_table
		dates.each_with_index do |date,index|
			puts "#{date}  #{@hostnames[index]}  #{@ips[index]}   #{@types[index]}"
		end
	end


end