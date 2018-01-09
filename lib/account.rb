require 'csv'

class Account
  attr_reader :number, :holder
  attr_accessor :balance
  @@global_account_number = 0

  def initialize(account_holder, balance = 0)
    @balance = balance
    @holder = account_holder
    @@global_account_number += 1
    @number = @@global_account_number
  end

  def deposit(amount)
    if amount <= 0
      puts "Amount must be greater than zero"
    else
      @balance += amount
      puts "Your balance is now: #{@balance}"
    end
    @balance
  end

  def withdraw(amount)
    if amount <= 0
      puts "Amount must be greater than zero"
    elsif amount > @balance
      puts "You do not have enough funds to withdraw this much"
      puts "Your balance is #{@balance}."
    else
      @balance -= amount
      puts "Your balance is now #{@balance}"
    end
    @balance
  end

  def close(csv_dir)
    table = CSV.table(csv_dir,{headers: true})
    table.delete_if do |row|
      row[:account_holder] == @holder
    end
    File.open(csv_dir, 'w') do |f|
      f.write(table.to_csv)
    end
    final_balance = @balance
    @balance = 0
    puts "Your account has been closed."
    final_balance
  end

end
