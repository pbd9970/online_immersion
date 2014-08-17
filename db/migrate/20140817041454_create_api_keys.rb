class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.references :user, index: true
      t.string :value

      t.timestamps
    end
    add_index :api_keys, :value, unique: true
  end
end
