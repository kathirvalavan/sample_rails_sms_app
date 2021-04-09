module AccountScopeConcern
  extend ActiveSupport::Concern
  included do
     default_scope {
       where(account_id: Account.current.id) if Account.current.present?
     }
  end
end
