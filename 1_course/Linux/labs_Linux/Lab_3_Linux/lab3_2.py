import random

with open('variants.txt', newline='') as f:
    lines = f.readlines()
    sentence = random.choice(lines).split(', ')
    sentence = [word.strip() for word in sentence]
    saying_char = sentence[0]
    about_char = sentence[1]
    subject = sentence[2]
    punc = sentence[3]
    print(f'a) The character that says a phrase is "{saying_char}"')
    print(f'\tb) The character that is talked with/about is  "{about_char}"')
    print(f'\t\tc) Should contain punctuation "{punc}"')
    print(f'\t\t\td) The subject that is talked about "{subject}"')

