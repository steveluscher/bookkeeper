class Bookkeeper::PaypalTransaction::MasspaySubpayment < Bookkeeper::PaypalTransaction
  
  def to_postings
    gross = self.notification.amount.cents.to_f / 100
    fee = self.notification.fee.to_f
    
    postings = []
    postings << payer_account.credit(gross + fee)
    postings << Account.paypal_fees_account.debit(fee) if(fee > 0)
    
    postings
  end
  
  def payer_account
    @payer_account ||= Account::Asset.find_by_account_number(self.notification.params['payer_email'])
  end
end
