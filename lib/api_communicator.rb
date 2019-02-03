require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  list_films = get_characters_data(character_name)["films"]

  list_films.collect do |url|
    JSON.parse(RestClient.get(url))
  end
end

def get_characters_data(character_name)
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  #RestClient.get('http://www.swapi.co/api/people/') is getting the data from JavaScript
  #which is in JavaScript form so...
  #...JSON.parse(response_string) converts the data so that ruby can interpret it.


  response_hash["results"].find do |character_info|
    character_info["name"].downcase.include? character_name
    binding.pry
  end
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each.with_index(1) do |film_data, index|
    puts "#{index}: #{film_data["title"]}"

  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  binding.pry
  print_movies(films)
end
