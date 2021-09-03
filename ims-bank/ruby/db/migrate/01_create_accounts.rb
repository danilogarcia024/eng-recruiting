class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.integer :account_number, null: false
      t.string :account_type
    end
  end
end