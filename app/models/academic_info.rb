# == Schema Information
#
# Table name: academic_infos
#
#  id         :integer          not null, primary key
#  padron     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  carreer    :string
#
# Indexes
#
#  index_academic_infos_on_user_id  (user_id)
#

class AcademicInfo < ActiveRecord::Base

belongs_to :user
end
