class Journal::Bill < Journal
  has_many   :payments, :as => :payable, :class_name => '::Journal'
  belongs_to :creditor, :polymorphic => true
  
  def amount
    postings.find(:first, :conditions => {:account_id => Account.accounts_payable}).amount
  end
  
  def amount_paid
    payments.inject(0) { |sum, payment| sum - payment.postings.find(:first, :conditions => {:account_id => Account.accounts_payable}).amount }
  end
  
  def paid_in_full?
    amount_paid >= amount
  end
  
  def overpaid?
    amount_paid > amount
  end
  
  def pay(payment_transaction)
    gross = payment_transaction.notification.amount.cents.to_f / 100
    
    journal = Journal::Disbursement.new(:transactable => payment_transaction)
    
    journal.postings |= payment_transaction.to_postings
    journal.postings << Account.accounts_payable.debit(gross)
    
    payments << journal
    save!
  end
end