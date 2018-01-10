class Customer
  attr_accessor :name, :accounts

  def initialize(username)
    @name = username
    @accounts = []
  end

  def total_funds
    total = @accounts.sum{ |account| account.balance}
    puts "You have #{total} invested with us"
    total
  end

end
