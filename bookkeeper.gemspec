Gem::Specification.new do |s|
  s.name = 'bookkeeper'
  s.version = '0.2.0'
  s.summary = 'A double-entry accounting system for Rails.'
  s.email = 'sluscher@stevenluscherdesign.com'
  s.homepage = ''
  s.description = 'This alpha release of Bookkeeper is intended for community feedback; please be advised that it will undergo significant changes between now and its 1.0 release.'
  s.has_rdoc = false
  s.authors = ['Steven Luscher', 'Scott Patten']
  s.add_dependency 'money'
  s.add_dependency 'aunderwo-acts_as_tree'
  s.add_dependency 'ryanb-acts-as-list'
  
  s.files = %w(init.rb
               lib/bookkeeper/account/asset.rb
               lib/bookkeeper/account/expense.rb
               lib/bookkeeper/account/liability.rb
               lib/bookkeeper/account/revenue.rb
               lib/bookkeeper/account.rb
               lib/bookkeeper/asset_type/cad.rb
               lib/bookkeeper/asset_type/usd.rb
               lib/bookkeeper/asset_type.rb
               lib/bookkeeper/batch.rb
               lib/bookkeeper/journal/bill.rb
               lib/bookkeeper/journal/deposit.rb
               lib/bookkeeper/journal/disbursement.rb
               lib/bookkeeper/journal/invoice.rb
               lib/bookkeeper/journal/transfer.rb
               lib/bookkeeper/journal.rb
               lib/bookkeeper/paypal_transaction/masspay_subpayment.rb
               lib/bookkeeper/paypal_transaction/single.rb
               lib/bookkeeper/paypal_transaction.rb
               lib/bookkeeper/posting.rb
               lib/bookkeeper.rb
               lib/immutable-attribute-plugin/init.rb
               lib/immutable-attribute-plugin/install.rb
               lib/immutable-attribute-plugin/lib/ensures_immutability_of.rb
               lib/immutable-attribute-plugin/MIT-LICENSE
               lib/immutable-attribute-plugin/Rakefile
               lib/immutable-attribute-plugin/README
               lib/immutable-attribute-plugin/tasks/ensures_immutability_of_tasks.rake
               lib/immutable-attribute-plugin/test/fixtures/accounts.yml
               lib/immutable-attribute-plugin/test/fixtures/infos.yml
               lib/immutable-attribute-plugin/test/rails_root/app/controllers/application.rb
               lib/immutable-attribute-plugin/test/rails_root/app/helpers/application_helper.rb
               lib/immutable-attribute-plugin/test/rails_root/app/models/account.rb
               lib/immutable-attribute-plugin/test/rails_root/app/models/info.rb
               lib/immutable-attribute-plugin/test/rails_root/config/boot.rb
               lib/immutable-attribute-plugin/test/rails_root/config/database.yml
               lib/immutable-attribute-plugin/test/rails_root/config/environment.rb
               lib/immutable-attribute-plugin/test/rails_root/config/environments/development.rb
               lib/immutable-attribute-plugin/test/rails_root/config/environments/mysql.rb
               lib/immutable-attribute-plugin/test/rails_root/config/environments/postgresql.rb
               lib/immutable-attribute-plugin/test/rails_root/config/environments/production.rb
               lib/immutable-attribute-plugin/test/rails_root/config/environments/sqlite.rb
               lib/immutable-attribute-plugin/test/rails_root/config/environments/sqlite3.rb
               lib/immutable-attribute-plugin/test/rails_root/config/environments/test.rb
               lib/immutable-attribute-plugin/test/rails_root/config/routes.rb
               lib/immutable-attribute-plugin/test/rails_root/db/migrate/001_create_accounts.rb
               lib/immutable-attribute-plugin/test/rails_root/db/migrate/002_create_infos.rb
               lib/immutable-attribute-plugin/test/rails_root/Rakefile
               lib/immutable-attribute-plugin/test/rails_root/README
               lib/immutable-attribute-plugin/test/rails_root/script/console
               lib/immutable-attribute-plugin/test/rails_root/script/runner
               lib/immutable-attribute-plugin/test/rails_root/test/test_helper.rb
               lib/immutable-attribute-plugin/test/rails_root/vendor/plugins/phone_validation/init.rb
               lib/immutable-attribute-plugin/test/test_helper.rb
               lib/immutable-attribute-plugin/test/unit/plugin_test.rb
               lib/immutable-attribute-plugin/uninstall.rb
               rails/init.rb
               rails_generators/bookkeeper_generator.rb
               rails_generators/templates/migration.rb
               rails_generators/templates/fixtures.yml
               rails_generators/USAGE)
end