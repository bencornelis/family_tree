class Person < ActiveRecord::Base

  has_many :mothers_children, :foreign_key => :mother_id, class_name: "Relationship"
  has_many :moms_children, through: :mothers_children, source: :child

  has_many :fathers_children, :foreign_key => :father_id, class_name: "Relationship"
  has_many :dads_children, through: :fathers_children, source: :child

  has_one :childs_moms, :foreign_key => :child_id, class_name: "Relationship"
  has_one :mom, through: :childs_moms, source: :mom

  has_one :childs_dads, :foreign_key => :child_id, class_name: "Relationship"
  has_one :dad, through: :childs_dads, source: :dad

  has_many :female_spouses, :foreign_key => :father_id, class_name: "Relationship"
  has_many :wives, -> { uniq }, through: :female_spouses, source: :wife

  has_many :male_spouse, :foreign_key => :mother_id, class_name: "Relationship"
  has_many :husbands, -> { uniq }, through: :male_spouse, source: :husband

  def has_children?
    self.moms_children.any? || self.fathers_children.any?
  end

  def spouses
    if gender == "male"
      wives
    else
      husbands
    end
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
      return_string = "<a href='/#{id}/edit'>#{name}</a>"
      return_string += "<ul>"
      spouses.each do |spouse|
        return_string += "#{name} & #{spouse.name}"
        return_string += "<ul>"
        spouse.children.each do |child|
          return_string += "<li>" + child.build_tree + "</li>"
        end
        return_string += "</ul>"
      end
      return_string += "</ul>"
      return return_string
    else
      return "<a href='/#{id}/edit'>#{name}</a>"
    end
  end

  def update_relationship(origin_parent, spouse_params)
    # only call on a child

    spouse_name = spouse_params["spouse_name"]
    spouse_gender = spouse_params["spouse_gender"]

    is_new_spouse = origin_parent.spouses.where(name: spouse_name, gender: spouse_gender).empty?

    if origin_parent.gender == "male"
      father_id = origin_parent.id

      if is_new_spouse
        spouse = origin_parent.spouses.create(name: spouse_name, gender: spouse_gender)
        mother_id = spouse.id
        Relationship.where(father_id: father_id, mother_id: mother_id, child_id: nil).first.update(child_id: id)
      else
        spouse = origin_parent.spouses.where(name: spouse_name, gender: spouse_gender).first
        Relationship.create(child_id: id, father_id: father_id, mother_id: spouse.id )
      end

    elsif origin_parent.gender == "female"
      mother_id = origin_parent.id
      if is_new_spouse
        spouse = origin_parent.spouses.create(name: spouse_name, gender: spouse_gender)
        father_id = spouse.id
        Relationship.where(father_id: father_id, mother_id: mother_id, child_id: nil).first.update(child_id: id)
      else
        spouse = origin_parent.spouses.where(name: spouse_name, gender: spouse_gender).first
        Relationship.create(child_id: id, father_id: spouse.id, mother_id: mother_id )
      end

    end


  end

end
