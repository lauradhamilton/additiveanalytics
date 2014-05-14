class AddStateForeignKey < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      ALTER TABLE providers
        ADD constraint fk_providers_states
        FOREIGN KEY (state)
        REFERENCES states(code)
    SQL
  end

  def self.down
    execute <<-SQL
    ALTER TABLE providers
      DROP FOREIGN KEY fk_providers_states
    SQL
  end
end
