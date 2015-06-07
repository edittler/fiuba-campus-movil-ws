# == Schema Information
#
# Table name: uploaded_data
#
#  id            :integer          not null, primary key
#  name          :string
#  url           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  group_id      :integer
#  uploader_name :string
#  file_type     :string
#  user_id       :integer
#
# Indexes
#
#  index_uploaded_data_on_group_id  (group_id)
#  index_uploaded_data_on_user_id   (user_id)
#

class UploadedDatum < ActiveRecord::Base
belongs_to :group
belongs_to :user
end
