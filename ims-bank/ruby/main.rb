require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'uri'
require 'net/http'

# Adding Models to Project
$: << File.dirname(__FILE__) + "/models"
require 'account'
require 'customer'
require 'transaction'
require 'customer_account'

set :protection, :except => :frame_options
set :bind, '0.0.0.0'
set :port, 8080
set :database, {adapter: "sqlite3", database: "Database.sqlite3"}

get '/' do
  uri = URI('https://quietstreamfinancial.github.io/eng-recruiting/transactions.json')
  res = Net::HTTP.get_response(uri)
  if res.is_a?(Net::HTTPSuccess)
    transactions = JSON.parse(res.body)

    Transaction.delete_all
    CustomerAccount.delete_all
    Account.delete_all
    Customer.delete_all

    transactions.each do |transaction|
      transaction_id = transaction["id"]
      transaction_amount = transaction["transaction_amount"]
      transaction_date = transaction["date"]
      account_id = transaction["account_id"] 
      account_number = transaction["account_number"]
      account_type = transaction["account_type"]
      customer_id = transaction["customer_id"]
      customer_name = transaction["customer_name"]
      customer_email = transaction["customer_email"]

      customer = Customer.where(customer_id: customer_id)[0]
      if customer.nil?
        customer = Customer.create(customer_id: customer_id, name: customer_name, email: customer_email)
      end
      account = Account.where(account_number: account_number, account_type: account_type)[0]
      if account.nil?
        account = Account.create(account_number: account_number, account_type: account_type)
      end
      if customer.accounts.where(id: account.id)[0].nil?
        customer.customer_accounts.create(account: account)
      end
      account.transactions.create(transaction_id: transaction_id, amount: transaction_amount[1..transaction_amount.size].to_d, transaction_date: DateTime.parse(transaction_date[1..transaction_date.size]))
    end
  end
  @customers = Customer.all
  erb :table
end