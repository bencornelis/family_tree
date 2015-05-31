describe(Person) do
  it('Will not create a person in the database if their name is not set') do
    person = Person.create(name: '')
    expect(Person.all()).to(eq([]))
  end

  it('capitalizes names') do
    person = Person.create(name: 'ben')
    expect(person.name).to(eq('Ben'))
  end

  describe('#children') do
    it("lists a parent's children") do
      ben = Person.create(name: 'ben')
      sally = Person.create(name: 'sally')
      Relationship.create(child_id: ben.id, parent_id: sally.id)
      expect(sally.children).to(eq([ben]))
    end
  end

  describe('#parents') do
    it("lists a child's parents") do
      ben = Person.create(name: 'ben')
      bob = Person.create(name: 'bob')
      susan = Person.create(name: 'susan')
      Relationship.create(child_id: ben.id, parent_id: bob.id)
      Relationship.create(child_id: ben.id, parent_id: susan.id)
      expect(ben.parents).to(eq([bob, susan]))
    end
  end

  describe('#spouses') do
    it("lists all the people a person shares children with") do
      ben = Person.create(name: 'ben')
      bob = Person.create(name: 'bob')
      susan = Person.create(name: 'susan')
      Relationship.create(child_id: ben.id, parent_id: bob.id)
      Relationship.create(child_id: ben.id, parent_id: susan.id)
      expect(bob.spouses).to(eq([susan]))
    end
  end
end
