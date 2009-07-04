class Bookkeeper::Batch < ActiveRecord::Base
  has_many :journals
  
  def pay(payment_transaction)
    # Get all of the bills associated with this batch
    bills = journals

    # What kind of fee have we paid as part of this payment?
    fee = BigDecimal(payment_transaction.notification.fee)
    if fee > 0
      logger.info "Recording the MassPay fee for MassPay subpayment #{payment_transaction.transaction_id}"
      fee_journal = Journal::Disbursement.new(:transactable => payment_transaction)

      fee_journal.postings << payment_transaction.payer_account.credit(fee)
      fee_journal.postings << Account.paypal_fees_account.debit(fee)

      fee_journal.save!
    end
    
    # How much cash have we paid as part of this payment?
    payment_dollars = BigDecimal(payment_transaction.notification.gross)
            
    while bills.length > 0
      bill = bills.shift
      amount_to_pay = bill.amount - bill.amount_paid
      
      logger.info "We have #{payment_dollars} left, and #{amount_to_pay} to pay for bill #{bill.id}, with #{bills.length} bills left to pay."
      if(payment_dollars < amount_to_pay)
        warn_mispayment(:under, bill.id, (amount_to_pay - payment_dollars))
        amount_to_pay = payment_dollars
      elsif(bills.length == 0 and payment_dollars > amount_to_pay)
        warn_mispayment(:over, bill.id, (payment_dollars - amount_to_pay))
        amount_to_pay = payment_dollars
      end
      
      if(amount_to_pay > 0)
        # Record a bill payment in the ledger
        logger.info "Recording a bill payment for bill #{bill.id}"
      
        journal = Journal::Disbursement.new(:transactable => payment_transaction)

        journal.postings << payment_transaction.payer_account.credit(amount_to_pay)
        journal.postings << Account.accounts_payable.debit(amount_to_pay)

        bill.payments << journal
        bill.save!
        
        payment_dollars -= amount_to_pay
      end
    end
  end
  
  private
    def warn_mispayment(extreme, bill_id, amount)
      case extreme
      when :over
        logger.warn "About to overpay bill #{bill_id} by $#{amount}."
      when :under
        logger.warn "About to underpay bill #{bill_id} by $#{amount}."
      end
    end
end
