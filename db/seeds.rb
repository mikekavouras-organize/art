# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

paintings_category = Category.create( name: 'Paintings' )
sculptures_category = Category.create( name: 'Sculptures')

Piece.create(category: paintings_category, title: 'Spiegel, blutrot (Mirror, Blood Red)', description: 'Gerhard Richter 1991 \n \n oil on glass \n \n  88 5/8 in. x 68 7/8 in. (225.11 cm x 174.94 cm)')

Piece.create(category: paintings_category, title: 'Untitled', description: 'A painting by the Russian-American Abstract expressionist artist Mark Rothko. It was painted in 1952. In common with Rothko’s other works from this period, it consists of large expanses of colour delineated by uneven, hazy shades.')

Piece.create(category: sculptures_category, title: 'David', description: 'David is a masterpiece of Renaissance sculpture created in marble between 1501 and 1504 by the Italian artist Michelangelo. David is a 5.17-metre marble statue of the Biblical hero David, a favoured subject in the art of Florence.')

Piece.create(category: sculptures_category, title: 'Pieta', description: 'The Pietà is a work of Renaissance sculpture by Michelangelo Buonarroti, housed in St. Peter\'s Basilica, Vatican City. It is the first of a number of works of the same theme by the artist. The statue was commissioned for the French Cardinal Jean de Bilhères, who was a representative in Rome.')
