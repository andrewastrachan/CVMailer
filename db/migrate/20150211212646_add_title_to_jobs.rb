class AddTitleToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :title, :string
  end
end
