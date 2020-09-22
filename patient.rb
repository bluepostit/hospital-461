class Patient
  attr_reader :name, :age
  attr_accessor :room, :id

  def initialize(attributes = {})
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @age = attributes[:age]
    @cured = attributes[:cured] || false
  end

  def cured?
    @cured
  end

  def cure!
    @cured = true
  end
end


# bob = Patient.new(name: 'bob')
# susan = Patient.new(name: 'susan', age: 23)

# p bob
# p susan
# puts bob.cured?
