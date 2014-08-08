class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :user, index: true
      t.belongs_to :chatroom, index: true
      t.string :message

      t.timestamps
    end
  end
end
