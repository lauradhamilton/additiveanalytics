require 'json'
require 'rails'

class MedicareCostSummary < ActiveRecord::Base

  def self.convert_medicare_cost_summary_to_json
    cost_summary_array = MedicareCostSummary.select([:provider_name, :state]).order('state ASC')
    total_records = MedicareCostSummary.count()
    cost_summary_hash_for_datatables = {"iTotalRecords" => total_records,
      "iTotalDisplayRecords" => total_records,
      "aaData" => cost_summary_array}.to_json.html_safe
  end

end
