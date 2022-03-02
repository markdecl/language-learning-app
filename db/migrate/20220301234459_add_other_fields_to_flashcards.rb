class AddOtherFieldsToFlashcards < ActiveRecord::Migration[6.0]
  def change
    add_column :flashcards, :scaled_frequency, :integer
    add_column :flashcards, :frequency_rank, :integer
    add_column :flashcards, :term_collocation_test, :string
    add_column :flashcards, :question, :string
    add_column :flashcards, :answer, :string
    add_column :flashcards, :term_with_accent, :string
    add_column :flashcards, :distinguishing_grammatical_info, :string
    add_column :flashcards, :conjugation_and_declension_info, :string
    add_column :flashcards, :top_three_grammatical_collocations, :string
    add_column :flashcards, :definition_being_tested, :string
    add_column :flashcards, :other_definitions, :string
    add_column :flashcards, :source_sentence, :string
    add_column :flashcards, :target_sentence, :string
    add_column :flashcards, :sentence_source, :string
    add_column :flashcards, :other_sentence_pairs, :string
    add_column :flashcards, :other_sentence_pairs_both, :string
  end
end
