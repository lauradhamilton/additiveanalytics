require 'json'
require 'rails'

class MedicareCostSummary < ActiveRecord::Base

  def self.convert_medicare_cost_summary_to_json
    cost_summaries = MedicareCostSummary.select([:state, :provider_name, :procedure_type, :procedures_count, :average_cost]).order('state ASC')
    total_records = MedicareCostSummary.count()
    cost_summary_hash_for_datatables = {"aaData" => cost_summaries}
  end

end
