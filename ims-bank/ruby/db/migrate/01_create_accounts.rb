class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.integer :number, null: false
      t.string :type, null: false
    end
  end
end