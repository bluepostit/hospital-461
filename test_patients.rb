require_relative 'patient'
require_relative 'patient_repository'
require_relative 'room_repository'

room_repo = RoomRepository.new('data/rooms.csv')
# Note: PatientRepository takes a RoomRepository instance
# as its second argument!
patient_repo = PatientRepository.new(
  'data/patients.csv',
  room_repo)

# Create a Room object and add it to the RoomRepository instance
room = Room.new(capacity: 2)
room_repo.add_room(room)

sally = Patient.new(name: 'sally', age: 24)
joe = Patient.new(name: 'joe', age: 34)
nina = Patient.new(name: 'nina', age: 26)

begin
  room.add_patient(sally)
  room.add_patient(joe)
  room.add_patient(nina)
rescue Room::CapacityReachedException
  puts "Sorry, we couldn't add the patient to the room"
end

patient_repo.add_patient(sally)
patient_repo.add_patient(joe)

# Output, demonstrating the relationships
patients = patient_repo.all
patients.each do |patient|
  puts "#{patient.name} (#{patient.age}) " \
    + "is in room #{patient.room.id}"
end
