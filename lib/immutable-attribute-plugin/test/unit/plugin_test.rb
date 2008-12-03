require 'test/unit'
require File.dirname(__FILE__) + '/../test_helper'

class ProtectedInfo < Info
  ensures_immutability_of :account
end

class ImmutableAccount < Account
  ensures_immutability_of :all
end

class EnsuresImmutabilityOfTest < Test::Unit::TestCase
  fixtures :accounts
  fixtures :infos

  def test_association_assignment_if_nil
    account = accounts(:nil_account)
    assert_nothing_thrown do
      account.info = infos(:foo)
    end
  end

  def test_error_on_association_assignment
    account = accounts(:wmoxam)
    account.info = infos(:foo)

    assert_raise ActiveRecord::ImmutableAttributeError do
      account.info = infos(:bar)
    end
  end

  def test_error_on_association_update
    account = accounts(:wmoxam)
	assert account.info.nil?
    account.info = infos(:foo)

    assert_raise ActiveRecord::ImmutableAttributeError do
      account.update_attributes(:info => infos(:bar))
    end
  end

  def test_error_on_belong_assignment
    zee_info = ProtectedInfo.create :text => "zee"

    assert_nothing_raised do
      zee_info.account = accounts(:wmoxam)
    end

    assert_raise ActiveRecord::ImmutableAttributeError do
      zee_info.account = accounts(:nil_account)
    end
  end

  def test_belong_id_readonly
    zee_info = ProtectedInfo.create :text => "zee"

    wmoxam_account = accounts(:wmoxam)
    assert_nothing_raised do
      zee_info.account = wmoxam_account
    end

    nil_account = accounts(:nil_account)

    zee_info.account_id = nil_account.id
    assert_not_equal zee_info.account_id, wmoxam_account.id, "Failed to forcefully set the id."
    zee_info.save!
    assert_equal zee_info.account_id, wmoxam_account.id, "The reload did not reset the id to correct id."
  end

  def test_protected_has_many_assignment
    account = accounts(:nil_account)
	assert account.infos.empty?, "Account infos should be empty"
	account.infos = [infos(:bar)]
    assert_raise ActiveRecord::ImmutableAttributeError do
      account.infos = [infos(:foo)]
    end
  end

def test_set_on_creation
    account = nil
    assert_nothing_thrown do
      account = Account.create(:username => 'jgreen')
    end
    assert account.valid?
    assert account.username == 'jgreen'
  end

  def test_set_same
    account = accounts(:wmoxam)
    assert_nothing_thrown do
      account.username = 'wmoxam'
    end
  end

  def test_assignment_if_nil
    account = accounts(:nil_account)
    assert_nothing_thrown do
      account.username = 'jgreen'
    end
    assert account.save
  end

  def test_overrides_all_setters_when_configured_with_all_symbol
    account = ImmutableAccount.create({
      :username => 'johndoe',
      :email => 'john.doe@example.org',
      :info => infos(:foo),
      :infos => [infos(:bar)]
    })
    assert_raise ActiveRecord::ImmutableAttributeError do
      account.username = 'janedoe'
    end
    assert_raise ActiveRecord::ImmutableAttributeError do
      account.email = 'jane.doe@example.org'
    end
    assert_raise ActiveRecord::ImmutableAttributeError do
      account.info = infos(:bar)
    end
    assert_raise ActiveRecord::ImmutableAttributeError do
      account.infos = [infos(:foo)]
    end
  end
  
  def test_error_on_assignment
    account = accounts(:wmoxam)
    assert_raise ActiveRecord::ImmutableAttributeError do
      account.username = 'jgreen'
    end
  end

  def test_error_on_update
    account = accounts(:wmoxam)
    assert_raise ActiveRecord::ImmutableAttributeError do
      account.update_attributes(:username => 'jgreen')
    end
  end
end
