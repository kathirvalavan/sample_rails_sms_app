class CreatePhoneNumber < ActiveRecord::Migration[6.1]
  def change
    create_table :phone_number, {:id => false} do |t|
      t.integer    :id, :null => false
      t.string     :number, limit: 40
      t.integer    :account_id
      t.timestamps
    end
    execute "ALTER TABLE phone_number ADD PRIMARY KEY (id);"

  end
end
