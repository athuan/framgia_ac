# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# (1..148).each do |i|
#   User.create(name: "user#{i}", email: "user#{i}@gmail.com", uid: "#{i}")
# end

User.create(display_name: "Hoang cong tuan anh", email: "hoang.cong.tuan.anh@framgia.com", uid: "B120007")
User.create(display_name: "nguyen minh thuan", email: "nguyen.minh.thuan@framgia.com", uid: "B120011")
User.create(display_name: "ngo minh son", email: "ngo.minh.son@framgia.com", uid: "B120041")
User.create(display_name: "dang thi xuan", email: "__deactivated__;dang.thi.xuan@framgia.com", uid: "B120042")
User.create(display_name: "nguyen thi hoa", email: "nguyen.thi.hoa@framgia.com", uid: "B120043")
User.create(display_name: "nguyen thi h", email: "nguyen.thi.a@framgia.com", uid: "B120078")