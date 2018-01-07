require 'csv'

puts "Hello! This wizard will create a new Customer - that's you!"
puts "----------------------------".center(50)

duplicate = true

while duplicate do
  puts "Please choose a username (case insensitve)"
  username = gets.chomp.downcase

  CSV.foreach("#{File.dirname(__FILE__)}/../storage/customers.csv") do |row|
    if row[0] = username
      duplicate = false
    end
  end
  puts "Sorry that username is already taken. Please try another" if duplicate
end

temp_storage = [username]

puts temp_storage
puts "Success!"

validated = false

while !validated do
  puts "Please enter a password. Passwords must be at least 8 characters long and include uppercase, lowercase and numeral characters"
  password1 = gets.chomp

  puts "Please re-enter your password to confirm. Passwords must be at least 8 characters long and include uppercase, lowercase and numeral characters"
  password2 = gets.chomp

  if password1==password2 &&
    password1.match(/([A-Za-z\d]+)/) != nil &&
    true # need to add confirmation that password contains at least one character from uppercase, lowercase and digit
    validated = true
    temp_storage << password1
  else
    puts "Password invalid \n\n"
  end
end

puts "Success! Thank you for registering. Your account has been created."

CSV.open("#{File.dirname(__FILE__)}/../storage/customers.csv", "ab") do |csv|
  csv << temp_storage
end
