require 'json'
require 'rails'

class MedicareCostSummary < ActiveRecord::Base

  def self.convert_medicare_cost_summary_to_json
    cost_summary_hash = MedicareCostSummary.select([:provider_name, :state]).order('state ASC')
    return cost_summary_hash.to_json
  end

end
