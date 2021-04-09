class PhoneNumber < ApplicationRecord
  self.table_name = "phone_number"
  belongs_to :account
  include AccountScopeConcern
end
