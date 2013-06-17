# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  provider          :string(255)
#  uid               :string(255)
#  name              :string(255)
#  oauth_token       :string(255)
#  oauth_expires_at  :datetime
#  created_at        :datetime
#  updated_at        :datetime
#  confirmation_code :string(255)
#  confirmed         :boolean          default(FALSE)
#  email             :string(255)
#

class User < ActiveRecord::Base
end
