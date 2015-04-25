# == Schema Information
#
# Table name: jobs
#
#  id         :integer          not null, primary key
#  company    :string
#  position   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :integer
#
# Indexes
#
#  index_jobs_on_profile_id  (profile_id)
#

require 'rails_helper'

RSpec.describe Job, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
end
