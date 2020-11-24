class AstroidView
  attr_reader :astroids_data
  def initialize(astroids_data, date)
    @astroids_data = astroids_data
    @date = date
  end

  def formatted_date
    DateTime.parse(@date).strftime("%A %b %d, %Y")
  end

  def astroid_list
    @astroids_data[:astroid_list]
  end

  def format_row_data(row_data, column_info)
    row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
    puts "| #{row} |"
  end

  def create_rows(astroid_data, column_info)
    rows = astroid_data.each { |astroid| format_row_data(astroid, column_info) }
  end

  def display
    column_labels = { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
    column_data = column_labels.each_with_object({}) do |(col, label), hash|
      hash[col] = {
        label: label,
        width: [astroid_list.map { |astroid| astroid[col].size }.max, label.size].max}
      end

      header = "| #{ column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
      divider = "+-#{column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"
    puts "______________________________________________________________________________"
    puts "On #{formatted_date}, there were #{@astroids_data[:total_number_of_astroids]} objects that almost collided with the earth."
    puts "The largest of these was #{@astroids_data[:biggest_astroid]} ft. in diameter."
    puts "\nHere is a list of objects with details:"
    puts divider
    puts header
    create_rows(astroid_list, column_data)
    puts divider
  end
end
