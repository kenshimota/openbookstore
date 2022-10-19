# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


def create_category
  cache = {}
  count = 0
  max = 1000
  index = 0

  while count < 20 and index < max
    name = Faker::Book.genre
    if !cache[name]
      count = 0
      cache[name] = true
      Category.create(name: name)
    else
      count += 1
    end
    index += 1
  end

end

def create_author
  cache = {}
  count = 0
  max = 1000
  index = 0

  while count < 20 and index < max
    name = Faker::Book.author

    if !cache[name]
      count = 0
      cache[name] = true
      Author.create(name: name)
    else
      count += 1
    end

    index += 1
  end

end


create_author
create_category
