class Flashcard < ApplicationRecord
  has_many :user_flashcards

  # require 'csv'
  # def self.import(file)
  #   CSV.foreach(file.path, headers: true) do |row|
  #     Flashcard.create! row.to_hash
  #   end
  # end
end
