repuire 'csv'

CSV.generate do |csv|
  column_names = %w(name time feature image)
  csv << column_names
  @flower_items.each do |item|
    column_values = [
      item.name,
      item.time,
      item.feature,
      item.image
    ]
    csv << column_values
  end
end