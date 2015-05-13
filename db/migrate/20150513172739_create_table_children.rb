class CreateTableChildren < ActiveRecord::Migration
  def change
    create_table(:children) do |t|
      t.column(:child_id, :int)
      t.column(:father_id, :int)
      t.column(:mother_id, :int)

      t.timestamps()
    end
  end
end
