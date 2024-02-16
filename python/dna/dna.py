import csv
import sys


def main():
    cmd_argument_count = len(sys.argv)
    # TODO: Check for command-line usage
    if cmd_argument_count != 3:
        print("Usage: python3 dna.py [csvfile] [dnafile]")
        sys.exit(1)

    # TODO: Read database file into a variable
    database_file = sys.argv[1]
    database = []
    with open(database_file) as csv_file:
        database_dict = csv.DictReader(csv_file)
        for row in database_dict:
            database.append(row)

    str_array = []
    with open(database_file) as csv_file:
        str_array_tmp = []
        str_csv = csv.reader(csv_file)
        for row in str_csv:
            str_array_tmp.append(row)
        for i in str_array_tmp[0]:
            if i != 'name':
                str_array.append(i)
    str_count_array = []
    # TODO: Read DNA sequence file into a variable
    dna_sequence_file = sys.argv[2]
    dna_sequence = ''
    with open(dna_sequence_file) as f:
        text_file = f.read()
        for text in text_file:
            dna_sequence += text

    # print(dna_sequence)
    # print(database)
    # TODO: Find longest match of each STR in DNA sequence
    for str_name in str_array:
        count = longest_match(dna_sequence, str_name)
        str_count_array.append(count)

    # TODO: Check database for matching profiles
    match = find_dna_matching_profile(str_count_array, database)
    print(match if match is not None else 'No match')

    return


def find_dna_matching_profile(str_counts, database):
    for profile in database:
        profile_strs = [int(profile[x]) for x in profile if x != 'name']
        if str_counts == profile_strs:
            return profile['name']

    return


def longest_match(sequence, subsequence):
    """Returns length of longest run of subsequence in sequence."""

    # Initialize variables
    longest_run = 0
    subsequence_length = len(subsequence)
    sequence_length = len(sequence)

    # Check each character in sequence for most consecutive runs of subsequence
    for i in range(sequence_length):

        # Initialize count of consecutive runs
        count = 0

        # Check for a subsequence match in a "substring" (a subset of characters) within sequence
        # If a match, move substring to next potential match in sequence
        # Continue moving substring and checking for matches until out of consecutive matches
        while True:

            # Adjust substring start and end
            start = i + count * subsequence_length
            end = start + subsequence_length

            # If there is a match in the substring
            if sequence[start:end] == subsequence:
                count += 1

            # If there is no match in the substring
            else:
                break

        # Update most consecutive matches found
        longest_run = max(longest_run, count)

    # After checking for runs at each character in seqeuence, return longest run found
    return longest_run


def longest_match_of_each_string(sequence, db):
    subsequences_count = []
    for index, subsequence in enumerate(db):
        sub = list(subsequence)[index + 1]
        subsequences_count.append(longest_match(sequence, sub))
    return subsequences_count


main()
