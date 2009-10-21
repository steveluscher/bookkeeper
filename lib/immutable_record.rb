module ActiveRecord
  class ImmutableRecordError < ActiveRecordError
    def initialize(message=nil)
      super(message || 'This record can no longer be modified; it has already been saved.')
    end
  end
end

module ImmutableRecord
  def destroy;          raise ActiveRecord::ImmutableRecordError unless new_record?; super; end
  def create_or_update; raise ActiveRecord::ImmutableRecordError unless new_record?; super; end
end