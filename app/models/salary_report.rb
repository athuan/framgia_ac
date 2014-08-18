class SalaryReport < ActiveRecord::Base
  has_many :sent_users
end
