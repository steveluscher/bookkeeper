class Journal::Transfer < Journal
  belongs_to :payable, :polymorphic => true
  
  def payable_type=(sType)
    super(sType.to_s.classify.constantize.base_class.to_s)
  end
end
