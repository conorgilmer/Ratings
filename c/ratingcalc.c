/* ratingcalc.c                                   */
/* Calculate your Rating change over a season     */
/* read in results from a csv file (results.csv)  */
/* and calculate rating change and averages etc.  */
/* by Conor Gilmer                                */

#include<stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

/* split string  function */
char** str_split(char* a_str, const char a_delim)
{
    char** result    = 0;
    size_t count     = 0;
    char* tmp        = a_str;
    char* last_comma = 0;
    char delim[2];
    delim[0]         = a_delim;
    delim[1]         = 0;

    /* Count how many elements will be extracted. */
    while (*tmp)
    {
        if (a_delim == *tmp)
        {
            count++;
            last_comma = tmp;
        }
        tmp++;
    }

    /* Add space for trailing token. */
    count += last_comma < (a_str + strlen(a_str) - 1);

    /* Add space for terminating null string so caller
       knows where the list of returned strings ends. */
    count++;

    result = malloc(sizeof(char*) * count);

    if (result)
    {
        size_t idx  = 0;
        char* token = strtok(a_str, delim);

        while (token)
        {
            assert(idx < count);
            *(result + idx++) = strdup(token);
            token = strtok(0, delim);
        }
        assert(idx == count - 1);
        *(result + idx) = 0;
    }

    return result;
} /* end of str_split */


/* calculate rating change for a game */
float calculate_rating(float mygrade, float opponents, float result)
{
	float extra   = 0;
	if ( result == 0){
                extra = -16;
                extra = extra + ((opponents-mygrade)/25);
                if ( extra > 0) extra=0;}
        else if ( result == 0.5){
                extra = 0;
                extra = extra + ((opponents-mygrade)/25);}
        else if ( result == 1){
                extra = 16;
                extra = extra + ((opponents-mygrade)/25);
                if ( extra < 0) extra=0;}

	return extra;


} /* end of calculate-rating */ 

/* main function */
int main(void)
{
	float  yourrating = 1650;
	float  newrating  = 0;
	float  opponent   = 0;
	float  change     = 0;
	float  rdiff      = 0;
	float  avgrat     = 0;
	float  avgres     = 0;
	float  results    = 0;
	float  result     = 0;
	int    games      = 0;

	char** colitems;

	printf("\n *** Starting ***\n");
	printf("\n Chess Rating Calculator\n");

	FILE *ptr_file;
    	char buf[1000];

    	ptr_file =fopen("results.csv","r");
    	if (!ptr_file)
       		return 1;

		printf("\nGames\tName\tClub\tGrade\tResult\tRDiff\tChange\n\n");
 	while (fgets(buf,1000, ptr_file)!=NULL)
	{
		colitems = str_split(buf, ',');
		avgrat   = avgrat + atof(colitems[3]);
		results  = results + atof(colitems[4]);
		games++;
		opponent = atof(colitems[3]);
		result   = atof(colitems[4]);
		rdiff    = atof(colitems[3]) - yourrating;
		change   = calculate_rating(yourrating, opponent, result);
		printf("%s\t%s\t%s\t%.0f\t%.1f\t%.2f\t%.2f\n", colitems[0],colitems[1],colitems[2],atof(colitems[3]),atof(colitems[4]), rdiff, change);
	}
	fclose(ptr_file);
	
	avgrat = avgrat / games;
	avgres = results / (float)games;
	printf("\nAverage\t\t\t  %.0f\t%.1f  Change\t%.2f\n",avgrat, avgres, change);	
	newrating = yourrating + change;
	printf("\n\n Season Summary\n");
	printf("\n ------------------------------");
	printf("\n Games                \t = %d",   games);
	printf("\n Results              \t = %.1f", results);
	printf("\n Avg. Opponents Rating\t = %.2f", avgrat);
	printf("\n Your New Rating      \t = %.0f",   newrating);
	printf("\n ------------------------------\n");
	printf("\n *** The End  ***\n");
    	return 0;


}
