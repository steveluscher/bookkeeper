class Account < ActiveRecord::Base
  acts_as_tree

  has_many  :postings
  belongs_to :accountable, :polymorphic => true
  
  validate :validate_account_created_through_a_subclass
  validate :validate_subaccount_same_type_as_parent, :if => :is_subaccount
  validate :validate_name_not_set, :if => :accountable_has_own_name
  validates_presence_of :name, :unless => :accountable_has_own_name
  
  def debit(amount, options = {})
    new_posting(:debit, amount, options)
  end
  
  def credit(amount, options = {})
    new_posting(:credit, amount, options)
  end
  
  def deposit(transaction)
    gross = transaction.notification.amount.cents.to_f / 100
    
    journal = Journal::Deposit.new(:transactable => transaction)
    
    journal.postings |= transaction.to_postings
    journal.postings << self.credit(gross)
    
    journal.save!
  end
  
  def account_type
    self.class::ACCOUNT_TYPE
  end
  
  def name
    accountable_has_own_name ? accountable.name : self[:name]
  end
  
  def postings_with_recursion
    (self_and_all_children.collect { |account| account.postings_without_recursion }).flatten
  end
  alias_method_chain :postings, :recursion
  
  def balance
    postings.inject(0) { |balance, p| 
      amount_from_account_perspective = [:asset,:expense].include?(account_type) ? -p.amount : p.amount
      balance + amount_from_account_perspective
    }
  end
  
  def is_subaccount
    self != self.root
  end
  
  def destroy
    raise ActiveRecord::IndestructibleRecord
  end
  
  class << self
    def accounts_payable; roots.find_by_name('Accounts Payable'); end
    def accounts_receivable; roots.find_by_name('Accounts Receivable'); end
  end
  
  private
    def new_posting(type, amount, params)
      params.assert_valid_keys(:asset_type)
      
      params.merge!(:account => self)
      
      case type
      when :debit
        params.merge!(:amount => -amount)
      when :credit
        params.merge!(:amount => amount)
      end
      
      Posting.new(params)
    end
    
    def accountable_has_own_name
      !self.accountable.name.nil? unless self.accountable.nil?
    end
    
    def validate_account_created_through_a_subclass
      errors.add_to_base 'Accounts may only be created by instantiating a subclass of Account.' if self.class == Account
    end
    
    def validate_subaccount_same_type_as_parent
      errors.add_to_base 'Subaccounts must be of the same type as their parent.' if self.class != self.parent.class
    end
    
    def validate_name_not_set
      errors.add :name, 'should not be set on an account with an accountable that has a name.'
    end
end
