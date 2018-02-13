class AddAttachmentAvatarToReadonusers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :readonusers do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :readonusers, :avatar
  end
end
