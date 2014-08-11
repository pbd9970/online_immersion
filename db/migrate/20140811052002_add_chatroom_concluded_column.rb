class AddChatroomConcludedColumn < ActiveRecord::Migration
  def change
    change_table :chatrooms do |t|
      t.boolean :concluded, default: false
    end
  end
end
