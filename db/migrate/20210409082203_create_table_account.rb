class CreateTableAccount < ActiveRecord::Migration[6.1]
  def change
    create_table :account, {:id => false } do |t|
      t.integer   :id, :null => false
      t.string    :auth_id, limit: 40
      t.string    :username, limit: 30
      t.timestamps
    end
    execute "ALTER TABLE account ADD PRIMARY KEY (id);"

 end
end
