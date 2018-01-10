class Customer
  attr_accessor :accounts

  def initialize(username)
    @username = username
    @accounts = []
  end

  def total_funds
    total = @accounts.sum{ |account| account.balance}
    puts "You have #{total} invested with us"
    total
  end

end
