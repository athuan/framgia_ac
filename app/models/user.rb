class User < ActiveRecord::Base
  
  scope :find_user, ->(display_name) do
    where("BINARY display_name = ?", "#{display_name}")
  end

  scope :find_uid, ->(uid) do
  	where(uid: uid)
  end

  scope :actives, -> do
  	where("email NOT LIKE '__deactivated__;%'")
  end
end
