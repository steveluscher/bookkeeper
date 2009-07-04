class Bookkeeper::Journal < ActiveRecord::Base
  has_many   :postings
  belongs_to :transactable, :polymorphic => true
  belongs_to :batch
  
  ensures_immutability_of :all
  
  validates_size_of :postings, :minimum => 2
  validates_associated :postings
  validate :validate_postings_sum_to_zero
  
  def destroy
    raise ActiveRecord::IndestructibleRecord
  end
  
  def transactable_type=(sType)
    super(sType.to_s.classify.constantize.base_class.to_s)
  end
  
  protected    
    def validate_postings_sum_to_zero
      errors.add :postings, 'must sum to zero.' unless postings_sum_to_zero
    end
    
    def postings_sum_to_zero
      sum = self.postings.inject(0) { |sum, posting| sum + posting.amount }
      sum == 0
    end
end
