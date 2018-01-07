require 'rspec'
require_relative '../lib/account'

describe Account do
# test Account.new
  it ".new should create a new Account" do
    expect(Account.new("holder")).to be_instance_of (Account)
  end

  it "should set balance for new account when given" do
    expect(Account.new("holder", 100).balance).to eq(100)
  end

  context "Once account has been created" do
    before do
      @account = Account.new("holder", 100)
    end

    describe "deposit" do
      it "should increase by deposit amount" do
        expect{@account.deposit(100)}.to change{@account.balance}.by(100)
      end

      it "should not increase balance for deposit amount <= 0" do
        expect{@account.deposit(-1)}.to change{@account.balance}.by(0)
      end
    end

    describe "withdraw" do
      it "should decrease by withdrawal amount" do
        expect{@account.withdraw(100)}.to change{@account.balance}.by(-100)
      end

      it "should not increase balance for deposit amount <= 0" do
        expect{@account.deposit(-1)}.to change{@account.balance}.by(0)
      end

      it "should not allow you to withdraw more than you have" do
        expect{@account.withdraw(200)}.to change{@account.balance}.by(0)
      end

    end

    describe "close" do
      before do
        @final_balance = @account.balance
      end

      it "should return final balance amount" do
        expect(@account.close).to eq(@final_balance)
      end

      context "once account is closed" do
        before do
          @account.close
        end

        it "should set balance to 0" do
          expect(@account.balance).to eq(0)
        end
      end
    end
  end
end
