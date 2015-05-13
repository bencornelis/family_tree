class Person < ActiveRecord::Base

  has_many :mothers_children, :foreign_key => :mother_id, class_name: "Relationship"
  has_many :moms_children, through: :mothers_children, source: :child

  has_many :fathers_children, :foreign_key => :father_id, class_name: "Relationship"
  has_many :dads_children, through: :fathers_children, source: :child

  has_one :childs_moms, :foreign_key => :child_id, class_name: "Relationship"
  has_one :mom, through: :childs_moms, source: :mom

  has_one :childs_dads, :foreign_key => :child_id, class_name: "Relationship"
  has_one :dad, through: :childs_dads, source: :dad

end
