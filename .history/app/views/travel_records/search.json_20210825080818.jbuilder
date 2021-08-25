# json.array! @spots do |spot|
#   json.id spot.id
#   json.name spot.name
#   json.locatinon spot.location
# end

json.array! @spots, :id, :name, :location