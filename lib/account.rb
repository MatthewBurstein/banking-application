class Account
  attr_reader :account_number, :account_holder
  attr_accessor :balance
  @@global_account_number = 0

  def initialize(account_holder, balance = 0)
    @@global_account_number += 1
    @account_number = @@global_account_number
    @balance = balance
    @account_holder = account_holder
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

  def close
    final_balance = @balance
    @balance = 0
    puts "Your account has been closed."
    final_balance
  end

end
