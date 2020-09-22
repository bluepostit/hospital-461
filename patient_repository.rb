require 'csv'
require_relative 'patient'

class PatientRepository
  def initialize(csv_file_path, room_repository)
    @csv_file_path = csv_file_path
    @room_repository = room_repository
    @patients = []
    @next_id = 1
    load_csv
  end

  def add_patient(patient)
    patient.id = @next_id
    @next_id += 1
    @patients << patient
    save_csv
  end

  def all
    @patients
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options).each do |row|
      row[:id]    = row[:id].to_i          # Convert column to Integer
      row[:cured] = row[:cured] == "true"  # Convert column to boolean
      patient = Patient.new(row)

      # What about the patient's room?
      # 1. Get the room ID from the CSV
      # 2. Get the actual Room OBJECT from the RoomRepository
      # 3. Set this object as the patient's room
      room_id = row[:room_id]
      room = @room_repository.find(room_id)
      patient.room = room

      @patients << patient
      @next_id = row[:id] + 1
    end
  end

  def save_csv
    csv_options = { }
    CSV.open(@csv_file_path, 'wb') do |csv|
      # Write the headers
      csv << ['id', 'name', 'age', 'cured', 'room_id']
      # Write the patients
      @patients.each do |patient|
        csv << [patient.id, patient.name, patient.age,
                patient.cured?, patient.room.id]
      end
    end
  end
end
