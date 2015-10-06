require_relative "zeustracker"
require_relative "aggregator"
require_relative "cctracker"


puts "ip_stealer started"
zeus_stealer = Zeustracker.new
aggregator = Aggregator.new
zeus_stealer.parse_sources
# ip_stealer.print_as_table

cc_stealer = Cctracker.new
cc_stealer.parse_sources
aggregator.aggregate(zeus_stealer)
aggregator.aggregate(cc_stealer)
aggregator.render_to_html