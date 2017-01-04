json.array! @guests do |guest|
  json.partial! 'api/guests/guest.json.jbuilder', guest: guest
end
