class PaypalTransaction::Single < PaypalTransaction
  
  def to_postings
    gross = self.notification.amount.cents.to_f / 100
    fee = self.notification.fee.to_f
    
    postings = []
    postings << account.debit(gross - fee)
    postings << Account.paypal_fees_account.debit(fee) if(fee > 0)
    
    postings
  end

end
