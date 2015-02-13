class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :company
      t.string :recipient
      t.string :address
      t.string :blurb
      t.string :email
      t.integer :user_id, null: false
      t.boolean :sent, null: false
      
      t.timestamps null: false
    end
  end
end
