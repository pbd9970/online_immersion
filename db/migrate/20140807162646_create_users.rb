class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :inactive, default: false
      t.boolean :banned, default: false

      t.timestamps
    end
  end
end
