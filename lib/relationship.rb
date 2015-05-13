class Relationship < ActiveRecord::Base
  belongs_to :child, foreign_key: "child_id", class_name: "Person"
  belongs_to :mom, foreign_key: "mother_id", class_name: "Person"
  belongs_to :dad, foreign_key: "father_id", class_name: "Person"
end
