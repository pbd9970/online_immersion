class CreateChatroomUsers < ActiveRecord::Migration
  def change
    create_table :chatroom_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :chatroom, index: true

      t.timestamps
    end
  end
end
