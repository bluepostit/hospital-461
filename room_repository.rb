require 'csv'
require_relative 'room'

class RoomRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @rooms = []
    @next_id = 1
    load_csv
  end

  def add_room(room)
    room.id = @next_id
    @next_id += 1
    @rooms << room
    save_csv
  end

  def find(id)
    # Return the first Room whose `id` matches `id`
    @rooms.find { |room| room.id == id }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options).each do |row|
      row[:id]    = row[:id].to_i # Convert column to Integer
      room = Room.new(row)
      @rooms << room
      @next_id = row[:id] + 1
    end
  end

  def save_csv
    csv_options = { }
    CSV.open(@csv_file_path, 'wb') do |csv|
      # Write the headers
      csv << ['id', 'capacity']
      # Write the rooms
      @rooms.each do |room|
        csv << [room.id, room.capacity]
      end
    end
  end
end
