class RenameChildrenToRelationships < ActiveRecord::Migration
  def change
    rename_table(:children, :relationships)
  end
end
