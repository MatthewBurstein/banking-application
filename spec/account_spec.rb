require 'rspec'
require 'CSV' unless defined?(CSV)
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
  #  before do
      let!(:account) {Account.new("holder", 100)}
  #  end

    describe "deposit" do
      it "should increase by deposit amount" do
        expect{account.deposit(100)}.to change{account.balance}.by(100)
      end

      it "should not increase balance for deposit amount <= 0" do
        expect{account.deposit(-1)}.to change{account.balance}.by(0)
      end
    end

    describe "withdraw" do
      it "should decrease by withdrawal amount" do
        expect{account.withdraw(100)}.to change{account.balance}.by(-100)
      end

      it "should not increase balance for deposit amount <= 0" do
        expect{account.deposit(-1)}.to change{account.balance}.by(0)
      end

      it "should not allow you to withdraw more than you have" do
        expect{account.withdraw(200)}.to change{account.balance}.by(0)
      end

    end

    describe "close" do

      let!(:final_balance) {account.balance}
      let(:accounts_csv) { "#{File.dirname(__FILE__)}/../storage/accounts.csv"}
      let(:accounts_spec_csv) { "#{File.dirname(__FILE__)}/../spec/spec_storage/accounts_spec.csv"}

      it "should return final balance amount" do
        expect(account.close(accounts_csv)).to eq(final_balance)
      end

      context "once account is closed" do
        before do
          account.close(accounts_spec_csv)
        end

        it "should set balance to 0" do
          expect(account.balance).to eq(0)
        end

        it "should remove row from csv (check by name)" do
          expect(CSV.read(accounts_spec_csv).flatten).not_to include(account.holder)
        end

        it "should remove row from csv (check by balance)" do
          expect(CSV.read(accounts_spec_csv).flatten).not_to include(account.balance)
        end

        it "should not remove other rows from csv" do
          expect(CSV.read(accounts_spec_csv).flatten).to include('alice', 'bob')
        end

        after do
          CSV.open(accounts_spec_csv,'ab') do |csv|
            csv << [3,'holder',60]
          end
        end
      end
    end
  end
end
