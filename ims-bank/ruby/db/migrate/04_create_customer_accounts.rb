class CreateCustomerAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :customer_accounts do |t|
      t.references :customer, foreign_key: true, null: false
      t.references :account, foreign_key: true, null: false
    
      t.timestamps
    end
  end
end
