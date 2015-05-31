require "pry"
class Person < ActiveRecord::Base

  has_many :parent_relationships, foreign_key: :child_id,
                                  class_name: "Relationship"

  has_many :parents, through: :parent_relationships

  has_many :child_relationships, foreign_key: :parent_id,
                                 class_name: "Relationship"

  has_many :children, through: :child_relationships

  before_save(:capitalize_name)
  validates(:name, :presence => true)

  def has_children?
    children.any?
  end

  def spouses
    spouses = []
    children.each do |child|
      spouses << child.parents.select { |parent| parent != self }.first
    end
    spouses.uniq
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

private
  def capitalize_name
    name.capitalize!
  end
end
