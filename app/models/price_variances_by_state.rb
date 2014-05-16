require 'json'
require 'rails'

class PriceVariancesByState < ActiveRecord::Base
  def self.convert_price_variance_data_to_json
    price_variance_hash = PriceVariancesByState.order('state ASC')
    return price_variance_hash.to_json
  end
end
