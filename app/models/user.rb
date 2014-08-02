class User < ActiveRecord::Base
  
  scope :find_user, ->(display_name) do
    where("BINARY display_name = ?", "#{display_name}")
  end
end
