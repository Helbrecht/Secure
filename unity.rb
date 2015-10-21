require_relative "aggregator"
require_relative "parsers/zeustracker"
require_relative "parsers/cctracker"
require_relative "parsers/alienvault"
require_relative "parsers/bambenek"
require_relative "parsers/malvare_domain_urls"

# puts "ip_stealer started"
# 
# aggregator = Aggregator.new
# 
# ip_stealer.print_as_table

aggregator = Aggregator.new

cc_stealer = Cctracker.new
cc_stealer.parse_sources
aggregator.add_records (cc_stealer.records)

av_stealer = Alienvault.new
av_stealer.parse_sources
aggregator.add_records (av_stealer.records)

zeus_stealer = Zeustracker.new
zeus_stealer.parse_sources
aggregator.add_records (zeus_stealer.records)

bamb_stealer = Bambenek.new
bamb_stealer.parse_sources
aggregator.add_records (bamb_stealer.records)

mdu_stealer = MalvareDomainUrls.new
mdu_stealer.parse_sources
aggregator.add_records (mdu_stealer.records)

aggregator.render_to_html
