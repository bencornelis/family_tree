class ChangeTableRelationships < ActiveRecord::Migration
  def change
    remove_column(:relationships, :mother_id)
    remove_column(:relationships, :father_id)
    add_column(:relationships, :parent_id, :integer)
  end
end
