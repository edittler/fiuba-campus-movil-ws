# == Schema Information
#
# Table name: nationalities
#
#  id          :integer          not null, primary key
#  nationality :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  profile_id  :integer
#

require 'rails_helper'

RSpec.describe Nationality, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
