require 'csv'
require_relative 'account.rb'

puts "Thank you for opening a new account with us."
puts "What is your username?"
username = gets.chomp.downcase

puts "Would you like to add money to the account now? (y/n)"
input = gets.chomp
if input == "y"
  puts "How much would you like to deposit?"
  amount = gets.chomp.to_i
else
  amount = 0
end

if amount > 0
  account = Account.new(username, amount)
else
  account = Account.new(username)
end

temp_storage = [account.number,account.holder,account.balance]

CSV.open("#{File.dirname(__FILE__)}/../storage/accounts.csv", "ab", headers: true) do |csv|
  csv << temp_storage
end
