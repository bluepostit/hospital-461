class Room
  class CapacityReachedException < Exception
  end

  attr_reader :number, :capacity, :patients
  attr_accessor :id

  def initialize(attributes = {})
    @number = attributes[:number]
    @capacity = attributes[:capacity] || 0
    @patients = attributes[:patients] || []
  end

  def add_patient(patient)
    if full?
      fail CapacityReachedException, 'The room is full!'
    else
      @patients << patient
      # Add THE CURRENT Room INSTANCE as the room for the Patient
      patient.room = self
    end
  end

  def full?
    @patients.length >= @capacity
  end
end
