class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.customer_id :integer, null: false
      t.string :name, null: false
      t.string :email, null: false
    end
  end
end
