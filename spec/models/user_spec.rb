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
#  first_name        :string(255)
#  last_name         :string(255)
#  image             :string(255)
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
  it {expect(subject).to respond_to(:anything)}
end
