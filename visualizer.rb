require_relative "record"

class Visualizer

	def self.get_template(records)
	 	%{
			<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"
				 \"http://www.w3.org/TR/html4/strict.dtd\">
				<HTML>
							   
					<BODY>
						<center>
							<table border=2 width=50% >
								<tr><td>Date</td><td>Hostname</td><td>Ip</td><td>Type</td><td>Source</td><td>Score</td></tr>
								<% records.each do |record|%>
									<tr> <td> <%= record.date %> </td> <td> <%= record.hostname%> </td> <td> <%= record.ip %> </td> <td> <%= record.type %> </td>  <td> <%= record.source::HTML %> </td> <td> <%= record.score %> </td> </tr>
								<% end %>
							</table>
						</center>
							  
					</BODY>
				</HTML>
		}	
	end

 	def get_template_deprecated
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

 	def self.render(records)
		ERB.new(get_template(records)).result(binding)
	end

	def self.render_to_html(records)
		Dir.mkdir("htmls") unless File.exist?("htmls")
		File.open("./htmls/Result.html", "w") do |f|
			f.write(render(records))
		end
	end


end