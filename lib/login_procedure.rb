require 'csv'

login = false

loop do
  puts "Please enter your username"
  temp_storage = [gets.chomp]

  puts "Please enter your password"
  temp_storage << gets.chomp.crypt(temp_storage[0])

  CSV.read("#{File.dirname(__FILE__)}/../storage/customers.csv").each do |row|
    login = true if row[0] == temp_storage[0] && row[1] == temp_storage[1]
  end
  if login
    puts "Success! Now to view your accounts"
    break
  else
    puts "Your username and/or password are incorrect.\n\n"
  end
end
