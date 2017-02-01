class Account < ActiveRecord::Base
  account_id: 'LT909'
  balance: 0
end

MoneyDeposited(account_id: 'LT101', amount: 100)
MoneyWithdrawn(account_id: 'LT909', amount: 50)

RailsEventStore::ReadModel.
  as(Account).
  from_stream([AccountCreated, MoneyDeposited, MoneyWithdrawn]).
  init( -> { { balance: 0 } }).
  when(AccountCreated), -> (state, event) { state[:account_id] = event.data[:account_id] }.
  when(MoneyDeposited, -> (state, event) { state[:balance] += event.data[:amount] }).
  when(MoneyWithdrawn, -> (state, event) { state[:balance] -= event.data[:amount] })

Account.find_by_account_id('LT909').balance = 50

current_balance
balance_this_week

RailsEventStore::ReadModel.
  as(Account).
  from_stream([Customer]).
  .map ( -> (event) {  }).
  .filter ( -> (event) {  })

filtered_stream = es.from_stream([Account]).
  filter( -> (event) {
    %w(MoneyDeposited AccountCreated).include?(event[:type]) &&
      event[:created_at] > 1.month.ago
  }.


RailsEventStore::ReadModel.
  as(Account).
  from_stream([AccountCreated, MoneyDeposited, MoneyWithdrawn]).
  init( -> (state) { model.balance: 0} ).
  when(AccountCreated), -> (state, event) { state.account_id = event.data[:account_id] }.
  when(MoneyDeposited, -> (state, event) { state.balance += event.data[:amount] }).
  when(MoneyWithdrawn, -> (state, event) { state.balance -= event.data[:amount] })
