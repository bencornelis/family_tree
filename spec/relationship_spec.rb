require "spec_helper"

describe(Relationship) do
  it("testing..") do
    person1 = Person.create(name: 'ben')
    person2 = Person.create(name: 'sally')
    person3 = Person.create(name: 'bob')
    child1 = Relationship.create(:child_id => person1.id, :mother_id => person2.id, :father_id => person3.id)
    binding.pry
  end
end
