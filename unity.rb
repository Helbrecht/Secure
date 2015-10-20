#require_relative "zeustracker"
require_relative "aggregator"
require_relative "cctracker"
require_relative "alienvault"

# puts "ip_stealer started"
# zeus_stealer = Zeustracker.new
# aggregator = Aggregator.new
# zeus_stealer.parse_sources
# ip_stealer.print_as_table

aggregator = Aggregator.new

cc_stealer = Cctracker.new
cc_stealer.parse_sources
aggregator.add_records (cc_stealer.records)
av_stealer = Alienvault.new
av_stealer.parse_sources
aggregator.add_records (av_stealer.records)
aggregator.render_to_html
