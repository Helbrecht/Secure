require_relative "record"
require_relative "parsers/cctracker"
require_relative "parsers/alienvault"
require_relative "parsers/zeustracker"
require_relative "parsers/bambenek"
require_relative "parsers/malvare_domain_urls"

class Scoring
	
	DATE_SCORE = 10
	HOST_SCORE = 20
	TYPE_SCORE = 20
	IP_SCORE = 50

	def self.count_score (records)
		records.each do |record|
			set_score(record)
		end
		return records
	end

	def self.set_score(record)
		score = 0
		score += record.date.nil? ? 0 : DATE_SCORE
		score += record.hostname.nil? ? 0 : HOST_SCORE
		score += record.type.nil? ? 0 : TYPE_SCORE
		score += ( record.ip.nil? || record.ip == "" ) ? 0 : IP_SCORE
		score *= get_score_for_source(record)
		record.score = score
	end


	def self.get_score_for_source(record)
		return record.source::SOURCE_SCORE
	end


end