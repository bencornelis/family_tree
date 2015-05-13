class Person < ActiveRecord::Base

  has_many :mothers_children, :foreign_key => :mother_id, class_name: "Relationship"
  has_many :moms_children, through: :mothers_children, source: :child

  has_many :fathers_children, :foreign_key => :father_id, class_name: "Relationship"
  has_many :dads_children, through: :fathers_children, source: :child

  has_one :childs_moms, :foreign_key => :child_id, class_name: "Relationship"
  has_one :mom, through: :childs_moms, source: :mom

  has_one :childs_dads, :foreign_key => :child_id, class_name: "Relationship"
  has_one :dad, through: :childs_dads, source: :dad

  def has_children?
    self.moms_children.any? || self.fathers_children.any?
  end

  def children
    if gender == "male"
      dads_children
    elsif gender == "female"
      moms_children
    end
  end

  def build_tree
    if has_children?
      return_string = ""
      return_string += "<a href='/#{id}/edit'>#{name}</a>"
      return_string += "<ul>"
      children.each do |child|
        return_string += "<li>" + child.build_tree + "</li>"
      end
      return_string += "</ul>"
      return return_string
    else
      return "<a href='/#{id}/edit'>#{name}</a>"
    end
  end


end
