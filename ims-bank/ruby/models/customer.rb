class Customer < ActiveRecord::Base
	has_many :customer_accounts
	has_many :accounts, through: :customer_accounts

  def total_balance
    total_checking + total_savings
  end

  def total_checking
    Transaction.where(account_id: self.accounts.where(account_type: "checking").map{|account| account.id}).sum(:amount)
  end

  def total_savings
    Transaction.where(account_id: self.accounts.where(account_type: "savings").map{|account| account.id}).sum(:amount)
  end
end