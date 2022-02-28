# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# db/seeds.rb
puts "Cleaning database..."
UserDeck.destroy_all

puts "Creating user decks..."

russian = { language: "Russian" }
portuguese =  { language: "Portuguese" }

[russian, portuguese].each do |attributes|
  user_deck = UserDeck.create!(attributes)
  puts "Created #{user_deck.language}"
end



puts "Cleaning database..."
Flashcard.destroy_all

puts "Creating flashcards..."

flashcards = [
  {front: "among other things", back: "среди прочего"},
  {front: "no", back: "нет"}
]

flashcards.each do |attributes|
  flashcard = Flashcard.create!(attributes)
  puts "Created #{flashcard.front}"
end



puts "Cleaning database..."
UserFlashcard.destroy_all

puts "Creating user flashcards..."

user_flashcards = [
  {user_deck_id: 1, flashcard_id: 1, next_review: "2022-02-26 00:00:00", due_to_learn: "2022-02-26 00:00:00", learnt: false},
  {user_deck_id: 1, flashcard_id: 2, next_review: "2022-02-26 00:00:00", due_to_learn: "2022-02-26 00:00:00", learnt: false}
]

user_flashcards.each do |attributes|
  user_flashcard = UserFlashcard.create!(attributes)
  puts "Created #{user_flashcard}"
end

puts "Finished!"
