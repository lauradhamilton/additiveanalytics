require 'rails'

class Provider < ActiveRecord::Base
  # Don't save empty strings. Store them as null values in the db.
  nilify_blanks

  def self.import_providers
    (0..100000).each do |provider_id|
      provider = AllscriptsIntegration.get_provider(provider_id)
      unless JSON[provider][0]['getproviderinfo'].nil?
        new_provider_hash = JSON[provider][0]['getproviderinfo'][0]
        new_provider = Provider.new

        new_provider.id = provider_id
        new_provider.last_name = new_provider_hash['LastName']
        new_provider.first_name = new_provider_hash['FirstName']
        new_provider.middle_name = new_provider_hash['MiddleName']
        new_provider.suffix_name = new_provider_hash['SuffixName']
        new_provider.prefix_name = new_provider_hash['PrefixName']
        new_provider.title_name = new_provider_hash['TitleName']
        new_provider.entry_code = new_provider_hash['EntryCode']
        new_provider.entry_pneumonic = new_provider_hash['EntryMneumonic']
        new_provider.provider_key_ext = new_provider_hash['ProviderKeyEXT']
        new_provider.npi = new_provider_hash['NPI']
        new_provider.address_line_1 = new_provider_hash['AddressLine1']
        new_provider.address_line_2 = new_provider_hash['AddressLine2']
        new_provider.city = new_provider_hash['City']
        new_provider.state = new_provider_hash['State'].strip # Remove whitespace
        new_provider.phone = new_provider_hash['Phone'].gsub(/\D/, '').to_i
        new_provider.fax = new_provider_hash['Fax'].gsub(/\D/, '').to_i
        new_provider.specialty = new_provider_hash['Specialty']
        new_provider.provider_is_inactive = new_provider_hash['ProviderIsInactiveFLAG']
        new_provider.expiration_date = new_provider_hash['ExpirationDT']
        new_provider.dea_number = new_provider_hash['DEANumber']

        # Method should be save
        # Only save if we don't have the provider yet
        new_provider.save unless Provider.find_by_id provider_id
      end

    end
  end
end
