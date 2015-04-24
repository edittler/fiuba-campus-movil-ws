class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.string     :member_type     # Necessary to make polymorphic members work
      t.integer    :member_id       # The id of the member that belongs to this group
      t.integer    :group_id        # The group to which the member belongs
      t.string     :membership_type # The type of membership the member belongs with

      t.timestamps null: false
    end

    add_index :group_memberships, [:member_id, :member_type]
    add_index :group_memberships, :group_id
  end
end
