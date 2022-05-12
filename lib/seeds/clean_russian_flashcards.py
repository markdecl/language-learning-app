import csv
import string
import re
from nltk.tokenize import word_tokenize

def clean_flashcard(raw_flashcard):
    flashcard_elements = raw_flashcard.split(',')
    if flashcard_elements[4][0] == '\"':
        flashcard_elements[4] == flashcard_elements[4][1:]
    if flashcard_elements[-1] == '\"':
        flashcard_elements[4] == flashcard_elements[:-1]

    for char in string.punctuation:
        flashcard_element[4].replace(' ' + char, char)


    return cleaned_flashcard

def clean_sentence(sent, capitalize):
    if len(sent) > 0:
        if sent[0] == '\"':
            sent = sent[1:]
        if sent[-1] == '\"':
            sent = sent[:-1]
        for char in ['?', '!', '.', ',', '\'', ':']: # string.punctuation:
            sent = sent.replace(' ' + char, char)
        sent = sent.replace('\' ', '\'')
        sent = sent.replace(' i ', ' I ')
        sent = sent.replace('i\'', 'I\'')
        if capitalize:
            sent = sent[0].upper() + sent[1:]

    return sent


def find_top_collocation(sents):
    tokens = []
    for sent in sents:
        for word in word_tokenize(sent):
            tokens.append(word)

    return tokens

# top_collocation = find_top_collocation(['Assuming you meant "" typist, "" I think we are okay.', 'Yes, 30 ecus is the price.', 'What matters is that you are both okay.', "Yes, I'm... I'm very well.", 'Oh no, that is okay.'])
# print(top_collocation)


with open("russian_flashcards_raw.csv", "r", encoding='utf-8') as russian_flashcards_raw:
    with open("russian_flashcards_cleaned.csv", "w+") as russian_flashcards_cleaned:
        reader = csv.DictReader(russian_flashcards_raw)
        fieldnames = ['scaled_frequency','frequency_rank','term_collocation_test','question','answer','term_with_accent','distinguishing_grammatical_info','conjugation_and_declension_info','top_three_grammatical_collocations','definition_being_tested','other_definitions','source_sentence','target_sentence','sentence_source','other_sentence_pairs','other_sentence_pairs_both',None]
        writer = csv.DictWriter(russian_flashcards_cleaned, fieldnames=fieldnames)
        writer.writeheader()

        for row in reader:

            # Remove bracketed text from English definition

            # print(row['source_sentence'], row['target_sentence'])

            row['question'] = clean_sentence(row['question'], capitalize=False)
            row['question'] = re.sub("[\(].*?[\)]", "", row['question'])
            # print(row['question'])

            row['answer'] = clean_sentence(row['answer'], capitalize=False)
            row['answer'] = re.sub("[\(].*?[\)]", "", row['answer'])
            # print(row['answer'])

            row['term_with_accent'] = clean_sentence(row['term_with_accent'], capitalize=False)

            row['conjugation_and_declension_info'] = clean_sentence(row['conjugation_and_declension_info'], capitalize=False)

            row['source_sentence'] = clean_sentence(row['source_sentence'], capitalize=True)
            row['target_sentence'] = clean_sentence(row['target_sentence'], capitalize=True)

            # row['source_sentence'] = [row['source_sentence'].replace(' ' + char, char) for char in string.punctuation]

            # print(row['source_sentence'], row['target_sentence'])

            # print(row)

            # print(row['other_sentence_pairs'])
            source_sentences = []
            target_sentences = []
            for sent_pair in row['other_sentence_pairs_both'].split('<br><br>'):
                if sent_pair not in ['\"', '']:
                    sents = sent_pair.split('<br><font color=""green"">')
                    source_sentences.append(sents[0])
                    target_sentences.append(sents[1][:-7])

            source_sentences = [clean_sentence(sent, capitalize=True) for sent in source_sentences]
            target_sentences = [clean_sentence(sent, capitalize=True) for sent in target_sentences]
            print(source_sentences)
            print(target_sentences)

            # cleaned_flashcard = clean_flashcard(line)
            # russian_flashcards_cleaned.write(cleaned_flashcard)

            writer.writerow(row)
