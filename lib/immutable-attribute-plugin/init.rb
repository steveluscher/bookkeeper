require File.join(File.dirname(__FILE__), 'lib', 'ensures_immutability_of')
require 'acts_as_tree'

ActiveRecord::Base.send(:include, EnsuresImmutabilityOf)
