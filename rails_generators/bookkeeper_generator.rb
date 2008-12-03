class BookkeeperGenerator < Rails::Generator::Base
  
  def manifest
  
    recorded_session = record do |m|  
      
      # Create a blank fixtures file for each model
      %w(accounts asset_types batches journals paypal_transactions postings).each do |table_name|
        m.template 'fixtures.yml', File.join('test/fixtures', "#{table_name}.yml")
      end
      
      # Generate the migration
      m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => "create_bookkeeper_tables"
    end
  end
  
end