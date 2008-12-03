class CreateInfos < ActiveRecord::Migration
  def self.up
    create_table :infos do |t|
      t.column :account_id, :integer
      t.column :text, :text
    end
  end

  def self.down
    drop_table :accounts
  end
end

