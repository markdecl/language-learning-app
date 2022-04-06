# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# db/seeds.rb


puts "Cleaning database..."
Deck.destroy_all

puts "Creating user decks..."

russian = { language: "Russian", name: "Russian" }
portuguese = { language: "Portuguese", name: "Portuguese" }
french =  { language: "French", name: "French" }

[russian, portuguese, french].each do |attributes|
  deck = Deck.create!(attributes)
  puts "Created #{deck.language}"
end




# puts "Cleaning database..."
# UserDeck.destroy_all

# puts "Creating user decks..."

# russian = { language: "Russian" }
# portuguese =  { language: "Portuguese" }

# [russian, portuguese].each do |attributes|
#   user_deck = UserDeck.create!(attributes)
#   puts "Created #{user_deck.language}"
# end



puts "Cleaning database..."
Flashcard.destroy_all

puts "Creating flashcards..."

# flashcards = [
#   {front: "among other things", back: "среди прочего"},
#   {front: "no", back: "нет"}
# ]

# flashcards.each do |attributes|
#   flashcard = Flashcard.create!(attributes)
#   puts "Created #{flashcard.front}"
# end

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'russian_flashcards_cleaned.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'utf-8') # check that this encoding works with cyrillic
csv.each do |row|
  #puts row.to_hash
  # puts row

  t = Flashcard.new
  t.deck_id = 1

  # Label test direction of flashard
  # if row['question'].include? "\""
  if row['question'].count("a-zA-Z") > 0
    # Make en->tl flashcard
    t.test_direction = 'en-tl'
  else
    # Make tl->en flashcard
    t.test_direction = 'tl-en'
  end

  t.scaled_frequency = row['scaled_frequency']
  t.frequency_rank = row['frequency_rank']
  t.term_collocation_test = row['term_collocation_test']
  t.question = row['question']
  t.answer = row['answer']
  t.term_with_accent = row['term_with_accent']
  t.distinguishing_grammatical_info = row['distinguishing_grammatical_info']
  t.conjugation_and_declension_info = row['conjugation_and_declension_info']
  t.top_three_grammatical_collocations = row['top_three_grammatical_collocations']
  t.definition_being_tested = row['definition_being_tested']
  t.other_definitions = row['other_definitions']
  t.source_sentence = row['source_sentence']
  t.target_sentence = row['target_sentence']
  t.sentence_source = row['sentence_source']
  t.other_sentence_pairs = row['other_sentence_pairs']
  t.other_sentence_pairs_both = row['other_sentence_pairs_both']
  t.save
  # puts "#{t.question}, #{t.answer} saved"


end


# puts "Cleaning database..."
# UserFlashcard.destroy_all

# puts "Creating user flashcards..."

# puts UserDeck.all
# puts Flashcard.all

# user_flashcards = [
#   {user_deck_id: 1, flashcard_id: 1, next_review: "2022-02-26 00:00:00", due_to_learn: "2022-02-26 00:00:00", learnt: false},
#   {user_deck_id: 1, flashcard_id: 2, next_review: "2022-02-26 00:00:00", due_to_learn: "2022-02-26 00:00:00", learnt: false}
# ]

# (1..Flashcard.all.count).each do |flashcard_id|
#   attributes = {user_deck_id: 1, flashcard_id: flashcard_id, next_review: "2022-02-26 00:00:00", due_to_learn: "2022-02-26 00:00:00", learnt: false}
#   user_flashcard = UserFlashcard.create!(attributes)
#   puts "Created #{user_flashcard}"
# end



# user_flashcards.each do |attributes|
#   user_flashcard = UserFlashcard.create!(attributes)
#   puts "Created #{user_flashcard}"
# end


puts "Finished!"
