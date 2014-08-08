class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.belongs_to :user, index: true
      t.string :provider
      t.string :uid
      t.string :token_key
      t.string :token_expiration

      t.timestamps
    end
    add_index :tokens, :uid
  end
end
