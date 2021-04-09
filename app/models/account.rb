class Account < ApplicationRecord
  self.table_name = "account"

  def set_current()
    Thread.current[:current_account] = self
  end

  def self.current
    Thread.current[:current_account]
  end

  def self.reset_current
    Thread.current[:current_account] = nil
  end

end
