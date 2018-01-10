require 'csv'

puts "Hello! This wizard will create a new Customer - that's you!"
puts "----------------------------".center(50)

user_storage = []

# Ask for, validate and store username

loop do
  puts "Please choose a username (case insensitve)"
  username = gets.chomp.downcase
  duplicate = false
  CSV.foreach("#{File.dirname(__FILE__)}/../storage/customers.csv", {headers: true}) do |row|
    duplicate = true if row[0] == username
  end
  if duplicate
    puts "Sorry that username is already taken. Please try another"
  else
    user_storage << username
    break
  end
end

puts "Success!"
sleep(1)

# Ask for, validate and store password

validated = false
password_match = false

while !password_match
  while !validated do
    puts "Please enter a password. Passwords must be at least 8 characters long and include uppercase, lowercase and numeral characters"
    password1 = gets.chomp
    if password1[/[A-Z]/] != nil && password1[/[a-z]/] != nil && password1[/[\d]/] != nil
      validated = true
    else
      puts "Password invalid \n\n"
    end
  end

  puts "Please confirm your password."
  password2 = gets.chomp
  if password1==password2
      password_match = true
      user_storage << password1.crypt(user_storage[0])
  else
    validated = false
    puts "Passwords do not match \n\n"
  end
end

puts "Success! Thank you for registering. Your account has been created."
# Add customer to customers.csv
CSV.open("#{File.dirname(__FILE__)}/../storage/customers.csv", "ab") do |csv|
  csv << user_storage
end
