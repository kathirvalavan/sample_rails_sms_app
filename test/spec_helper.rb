module SpecHelper

  def set_account
    Account.first.set_current
  end

end
