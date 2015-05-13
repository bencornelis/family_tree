class CreateTablePeople < ActiveRecord::Migration
  def change
    create_table(:people) do |t|
      t.column(:name, :string)
      t.column(:gender, :string)
      t.column(:is_top, :boolean)

      t.timestamps()
    end
  end
end
