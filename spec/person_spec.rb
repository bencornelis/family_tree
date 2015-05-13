describe(Person) do
  it('Will not create a person in the database if their name is not set') do
    person = Person.create(name:'' , gender: 'male')
    expect(Person.all()).to(eq([]))
  end

  it('capitalizes names') do
    person = Person.create(name: 'ben', gender: 'male')
    expect(person.name).to(eq('Ben'))
  end
end
