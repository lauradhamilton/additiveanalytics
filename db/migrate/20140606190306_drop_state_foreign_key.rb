class DropStateForeignKey < ActiveRecord::Migration
  def self.up
    execute 'ALTER TABLE providers DROP CONSTRAINT fk_providers_states'
  end

  def self.down
    execute <<-SQL
      ALTER TABLE providers
        ADD constraint fk_providers_states
        FOREIGN KEY (state)
        REFERENCES states(code)
    SQL
  end
end
