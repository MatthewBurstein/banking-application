require 'csv'

login = false

loop do
  puts "Please enter your username"
  temp_storage = [gets.chomp]

  puts "Please enter your password"
  temp_storage << gets.chomp

  CSV.read("#{File.dirname(__FILE__)}/../storage/customers.csv").each do |row|
    if row[0] == temp_storage[0] && row[1] == temp_storage[1]
      puts "Success! Now to view your accounts"
      login = true
    else
      puts "Your username or password are incorrect.\n\n"
    end
  end
  break if login
end
