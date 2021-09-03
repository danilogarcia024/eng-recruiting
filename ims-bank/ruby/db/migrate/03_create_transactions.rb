class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :account, foreign_key: true, null: false
      t.decimal :amount, null: false
      t.datetime :transaction_date, null: false
    end
  end
end