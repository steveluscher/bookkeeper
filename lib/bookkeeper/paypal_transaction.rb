class Bookkeeper::PaypalTransaction < ActiveRecord::Base
  include ActiveMerchant::Billing::Integrations
  
  serialize :notification, Paypal::Notification
    
  has_one :journal, :as => :transactable
  
  private
    def account
      @account ||= Account::Asset.find_by_account_number(self.notification.account)
    end
end
