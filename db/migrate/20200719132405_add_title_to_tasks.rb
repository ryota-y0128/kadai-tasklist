class AddTitleToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :title, :status
  end
end
