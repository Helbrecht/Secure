require_relative "record"
require_relative "scoring"
require_relative "visualizer"

require 'erb'

class Aggregator

	attr_accessor :records

	def initialize
		@records = []
	end

	def add_records(records)
		records = count_score(records)
		@records += records
	end

  def print_as_table
		@records.each_with_index do |record|
			puts record.to_s
		end
		return 0
	end

	def render_to_html
		@records.sort! { |a,b| a.score <=> b.score }
		Visualizer.render_to_html(@records.reverse)
	end

	def count_score(records)
		return Scoring.count_score(records)
	end

end