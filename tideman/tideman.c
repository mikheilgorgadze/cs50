#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <strings.h>



// Max number of candidates
#define MAX 9

// preferences[i][j] is number of voters who prefer i over j
int preferences[MAX][MAX];

// locked[i][j] means i is locked in over j
bool locked[MAX][MAX];

// Each pair has a winner, loser
typedef struct
{
    int winner;
    int loser;
} pair;

// Array of candidates
string candidates[MAX];
pair pairs[MAX * (MAX - 1) / 2];

int pair_count;
int candidate_count;

// Function prototypes
bool vote(int rank, string name, int ranks[]);
void record_preferences(int ranks[]);
void add_pairs(void);
void sort_pairs(void);
void lock_pairs(void);
void print_winner(void);
bool is_ranked_higher(int x, int y, int arr[], int size);
bool is_preferred(int x, int y);
//void prevent_loop(int winner_ind, int loser_ind);
bool cycle(int end, int cycle_start);

int main(int argc, string argv[])
{
    // Check for invalid usage
    if (argc < 2)
    {
        printf("Usage: tideman [candidate ...]\n");
        return 1;
    }

    // Populate array of candidates
    candidate_count = argc - 1;
    if (candidate_count > MAX)
    {
        printf("Maximum number of candidates is %i\n", MAX);
        return 2;
    }
    for (int i = 0; i < candidate_count; i++)
    {
        candidates[i] = argv[i + 1];
    }

    // Clear graph of locked in pairs
    for (int i = 0; i < candidate_count; i++)
    {
        for (int j = 0; j < candidate_count; j++)
        {
            locked[i][j] = false;
        }
    }

    pair_count = 0;
    int voter_count = get_int("Number of voters: ");

    // Query for votes
    for (int i = 0; i < voter_count; i++)
    {
        // ranks[i] is voter's ith preference
        int ranks[candidate_count];

        // Query for each rank
        for (int j = 0; j < candidate_count; j++)
        {
            string name = get_string("Rank %i: ", j + 1);

            if (!vote(j, name, ranks))
            {
                printf("Invalid vote.\n");
                return 3;
            }
        }

        record_preferences(ranks);

        printf("\n");


        
        // printf("[");
        // for (int l = 0; l < candidate_count; l++){
        //     printf("%d, ", ranks[l]);
        // }
        // printf("]");
        // printf("\n");

    }

    //delete later
//     for (int i = 0; i < candidate_count; i++)
//     {
//         for (int j = 0; j < candidate_count; j++)
//         {
//             printf("[%i]", preferences[i][j]);
//         }
//         printf("\n");
//     }
    


    add_pairs();
    sort_pairs();
    lock_pairs();
    print_winner();

    // for debugging


//    for (int i = 0; i < pair_count; i++){
//        int x = pairs[i].winner;
//        int y = pairs[i].loser;
//        printf("(%d, %d) - %d pref_count, %d difference \n", pairs[i].winner, pairs[i].loser, preferences[x][y],preferences[x][y] - preferences[y][x]);
//    };



    //locked pairs debug
//    for (int i = 0; i < candidate_count; i++){
//        for (int j = 0; j < candidate_count; j++)
//        {
//            printf("[%d]", locked[i][j]);
//        }
//        printf("\n");
//    }

    return 0;
}

// Update ranks given a new vote
bool vote(int rank, string name, int ranks[])
{

    // TODO
    for (int i = 0; i < candidate_count; i++)
    {
        if (strcasecmp(name, candidates[i]) == 0)
        {
            ranks[rank] = i;
            return true;

        }
    }
    return false;
}

// Update preferences given one voter's ranks
void record_preferences(int ranks[])
{

    for (int i = 0; i < candidate_count; i++){
        for (int j = 0; j < candidate_count; j++){
            if (is_ranked_higher(ranks[i], ranks[j], ranks, candidate_count)){
                preferences[ranks[i]][ranks[j]]++;
            }
        }
    }

    // TODO
    return;
}

// Record pairs of candidates where one is preferred over the other
void add_pairs(void)
{
    for (int i = 0; i < candidate_count; i++){
        for (int j = 0; j < candidate_count; j++){
            int x = preferences[i][j];
            int y = preferences[j][i];
            pair p1;
            if (is_preferred(x, y)){
                p1.winner = i;
                p1.loser  = j;
                pair_count++;
                pairs[pair_count-1] = p1;
            }
        }
    }
    // TODO
    return;
}

// Sort pairs in decreasing order by strength of victory
void sort_pairs(void)
{
    for (int i = 0; i < pair_count; i++){
        for (int j = i; j < pair_count; j++){
                pair dummy;
                int x = pairs[j].winner;
                int y = pairs[j].loser;
                if (preferences[pairs[i].winner][pairs[i].loser] < preferences[x][y]) {
                    dummy = pairs[i];
                    pairs[i] = pairs[j];
                    pairs[j] = dummy;
                }
        }
    }

    for (int i = 0; i < pair_count; i++){
        int ix = pairs[i].winner;
        int iy = pairs[i].loser;
        int idiff = preferences[ix][iy] - preferences[iy][ix];
        for (int j = i; j < pair_count; j++){
                pair dummy;
                int jx = pairs[j].winner;
                int jy = pairs[j].loser;
                int jdiff = preferences[jx][jy] - preferences[jy][jx];

                if (jdiff > 0) {
                    if (idiff < jdiff){
                        dummy = pairs[i];
                        pairs[i] = pairs[j];
                        pairs[j] = dummy;
                    }
                }
        }
    }

    // TODO
    return;
}

// Lock pairs into the candidate graph in order, without creating cycles
void lock_pairs(void){
    for (int i = 0; i < pair_count; i++){
        if (!cycle(pairs[i].loser, pairs[i].winner)){
            locked[pairs[i].winner][pairs[i].loser] = true;
        }
    }


    // TODO
    return;
}

// Print the winner of the election
void print_winner(void)
{
    for (int i = 0; i < candidate_count; i++){
        int sum = 0;  
        for (int j = 0; j < candidate_count; j++){
            sum = sum + locked[j][i];
        }

        if (sum == 0){
            printf("%s\n", candidates[i]);
        }

    }

    // TODO
    return;
}

bool is_ranked_higher(int x, int y, int arr[], int size) {
    int left = -1;
    int right = -1;

    for (int i = 0; i < size; i++){
        if (arr[i] == x){
            left = i;
        }

        if (arr[i] == y){
            right = i;
        }
    }

    if (left < right) {
        return true;
    }else {
        return false;
    }
}

bool is_preferred(int x, int y){
    return x > y;
}

bool cycle(int end, int cycle_start){
    // Return True if there is a cycle created (recursion base case)
    if (end == cycle_start)
    {
        return true;
    }
    // Loop through candidates
    for (int i = 0; i < candidate_count; i++)
    {
        if(locked[end][i])
        {
            if(cycle(i, cycle_start))
            {
                return true;
            }
        }
    }
    return false;
}
