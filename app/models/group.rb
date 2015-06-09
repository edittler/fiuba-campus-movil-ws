# == Schema Information
#
# Table name: groups
#
#  id                   :integer          not null, primary key
#  name                 :string
#  description          :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Group < ActiveRecord::Base
  groupify :group, members: [:users], default_members: :users
  has_one :forum
  has_many :uploaded_data

  has_attached_file :picture,
                    styles: {
                              medium: "600x600>",
                              small:  "300x300>",
                              thumb: "100x100>"
                            },
                    path: ":style/:id_:updated_at_:filename",
                    default_url: "",
                    storage: :dropbox,
                    dropbox_credentials: Rails.root.join("config/dropbox.yml"),
                    dropbox_visibility: 'private'
  validates_attachment_content_type :picture,
                                    content_type: /\Aimage\/.*\Z/

def picture_url
    if picture.exists?
      return picture.url(:small)
    end
    return ""
  end  
end
