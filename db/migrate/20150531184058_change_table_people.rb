class ChangeTablePeople < ActiveRecord::Migration
  def change
    remove_column(:people, :gender)
    rename_column(:people, :is_top, :tree_top)
  end
end
