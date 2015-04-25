# == Schema Information
#
# Table name: academic_infos
#
#  id         :integer          not null, primary key
#  padron     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_academic_infos_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe AcademicInfo, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
end
