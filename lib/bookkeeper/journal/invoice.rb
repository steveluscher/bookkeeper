class Journal::Invoice < Journal
  has_many   :payments, :as => :payable, :class_name => '::Journal'
  belongs_to :debtor, :polymorphic => true
end