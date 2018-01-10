require 'csv'
require_relative '../classes/customer.rb'
require_relative '../classes/account.rb'

login = false

loop do
  puts "Please enter your username"
  @username = gets.chomp.downcase

  puts "Please enter your password"
  password = gets.chomp.crypt(@username)

  CSV.read(File.join(File.dirname(__FILE__), "../../storage/customers.csv")).each do |row|
    login = true if row[0] == @username && row[1] == password
  end
  if login
    break
  else
    puts "Your username and/or password are incorrect.\n\n"
  end
end

puts "Success! Now to view your accounts"
customer = Customer.new(@username)

CSV.read("#{File.dirname(__FILE__)}/../../storage/accounts.csv", {headers: true}).each do |row|
  if row[1] == customer.name
    puts "row[0] is #{row[0]}"
    puts "row[1] is #{row[1]}"
    puts "row[2] is #{row[2]}"
    account = Account.new(customer.name, row[0], row[2])
    customer.accounts << account
  end
end

if customer.accounts = []
  puts "You do not have any accounts with us. Would you like to open one?"
  # link to new account procedure
else
  # Link to what would you like to do menu
end
