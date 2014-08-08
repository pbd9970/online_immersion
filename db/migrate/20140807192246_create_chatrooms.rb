class CreateChatrooms < ActiveRecord::Migration
  def change
    create_table :chatrooms do |t|
      t.belongs_to :language, index: true
      t.boolean :matched, default: false

      t.timestamps
    end
  end
end
