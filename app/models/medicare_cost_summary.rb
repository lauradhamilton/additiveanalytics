require 'json'
require 'rails'

class MedicareCostSummaries < ActiveRecord::Base

  def self.medicare_cost_summaries_as_json
    cost_summary = MedicareCostSummary
  return cost_summary.to_json
  end

end
