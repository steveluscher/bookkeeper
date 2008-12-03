class CreateBookkeeperTables < ActiveRecord::Migration

  def self.up
    create_table :accounts do |t|
      t.integer     :parent_id
      t.string      :type
      t.string      :name
      t.string      :account_number
      t.references  :accountable, :polymorphic => true
      t.timestamps
    end
    
    Account::Asset.create!(:name => 'Accounts Receivable')
    Account::Liability.create!(:name => 'Accounts Payable')

    create_table :asset_types do |t|
      t.string      :name
      t.string      :symbol
      t.string      :type
    end
    
    AssetType::CAD.create!(:name => 'Canadian Dollar', :symbol => '$')
    AssetType::USD.create!(:name => 'US Dollar', :symbol => '$')

    create_table :batches do |t|
      t.timestamps
    end

    create_table :journals do |t|
      t.string     :type
      t.references :transactable, :polymorphic => true
      t.references :payable, :polymorphic => true
      t.references :creditor, :polymorphic => true
      t.references :debtor, :polymorphic => true  
      t.references :batch
      t.timestamps
    end

    create_table :paypal_transactions do |t|
      t.string    :type
      t.text      :notification
      t.string    :transaction_id
      t.timestamps
    end

    create_table :postings do |t|
      t.integer     :journal_id
      t.references  :asset_type
      t.integer     :account_id
      t.string      :accounting_period
      t.decimal     :amount, :precision => 14, :scale => 2, :null => false
      t.timestamps
    end

  end

  def self.down
    drop_table :accounts
    drop_table :asset_types
    drop_table :batches
    drop_table :journals
    drop_table :paypal_transactions
    drop_table :postings
  end

end