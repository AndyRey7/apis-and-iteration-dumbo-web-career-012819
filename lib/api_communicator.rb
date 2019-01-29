require 'rest-client'
require 'json'
require 'pry'
# {"count"=>87,
#  "next"=>"https://www.swapi.co/api/people/?page=2",
#  "previous"=>nil,
#  "results"=>
#   [{"name"=>"Luke Skywalker",
#     "height"=>"172",
#     "mass"=>"77",
#     "hair_color"=>"blond",
#     "skin_color"=>"fair",
#     "eye_color"=>"blue",
#     "birth_year"=>"19BBY",
#     "gender"=>"male",
#     "homeworld"=>"https://www.swapi.co/api/planets/1/",
#     "films"=>
#      ["https://www.swapi.co/api/films/2/",
#       "https://www.swapi.co/api/films/6/",
#       "https://www.swapi.co/api/films/3/",
#       "https://www.swapi.co/api/films/1/",
#       "https://www.swapi.co/api/films/7/"],
#     "species"=>["https://www.swapi.co/api/species/1/"],
#     "vehicles"=>

def get_character_movies_from_api(character_name)
  #make the web request

  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  list_films = get_characters_data(character_name, response_hash)["films"]

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  list_films.collect do |url|
    JSON.parse(RestClient.get(url))
  end

end

def get_characters_data(character_name, response_hash)

  response_hash["results"].find do |character_info|
    character_info["name"].downcase.include? character_name
  end

end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
