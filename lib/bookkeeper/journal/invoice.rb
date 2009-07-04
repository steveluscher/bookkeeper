class Bookkeeper::Journal::Invoice < Bookkeeper::Journal
  has_many   :payments, :as => :payable, :class_name => '::Journal'
  belongs_to :debtor, :polymorphic => true
end