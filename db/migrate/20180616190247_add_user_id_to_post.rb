class AddUserIdToPost < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :posts, :user
  end
end
