/* chess games recording system 
 * add a game
 * show games records
 * search record of games
 * update game record
 * delete game record
 * print report of games, and calculate the rating change from the game
 * calculate the rating change after all games, calculate the average rating etc.
 *
 * records stored in a binary file games.rec
 *
 */

#include<iostream>
#include<fstream>
#include<string>
#include<cstdlib>
using std::cout;
using std::cin;
using std::endl;
using std::fstream;
using std::ofstream;
using std::ifstream;
using std::ios;
using std::string;

/* users rating and filename */
const int myrating = 1650; 
const string filename = "games.rec";

class game_record
{
    private:
//	int  game_no;
        char name[12];
        char club[10];
	char competition[12];
//	int  icucode;  // add in later
        int  opponent_rating;
        char result;
    public:
        void read_data();
        void generate_report();
        void show_data(int);
        void write_record();
        void read_record();
        void search_record();
        void edit_record();
        void delete_record();
};

/* generate report and calculate rating change for each game */
void game_record::generate_report()
{   int    game     = 0;
    double score    = 0;
    double a_rating = 0;
    double change   = 0;
    double t_change = 0;
    int    rdiff    = 0;

    ifstream infile;
    infile.open(filename, ios::binary);
    if(!infile)
    {
        cout<<"Error in Opening! "<< filename <<" File Not Found!!"<<endl;
        return;
    }
    cout<<"\n*** \t \t Report Data from file \t \t ***"<<endl;
    cout<<"\nGame\tName\tClub\tGrade\tResult\tRdiff\tChange"<<endl;
    while(!infile.eof())
    {
        if(infile.read(reinterpret_cast<char*>(this), sizeof(*this))>0)
        { game++;
	  a_rating = a_rating + (double) opponent_rating;
	  rdiff = opponent_rating - myrating;
	/* calculate rating change */
	if (result == 'w' || result == 'W') {
	  score = 1.0 + score;
	  change = +16  + (((double)rdiff) / 25.0);
	  if (change < 0 ) {
		change = 0;
	  }
	}
	if (result == 'd' || result == 'D') {
	  score = 0.5 + score;
	  change = (((double)rdiff) /25.0);
        }
	if (result == 'l' || result == 'L') {
		change = -16  + (((double)rdiff)/25.0);
        }
	 cout<<" "<<game<<"\t"<<name<<"\t" <<club<<"\t"<<opponent_rating<< "\t"<<result<<"\t"<<rdiff<<"\t"<<change<<endl;
        t_change = t_change + change;
        }
    } /* end of while loop */
    a_rating = a_rating/game;
    cout<<"\n\tAverage\t\t"<<a_rating<<"\t"<<score<<"\tChange\t"<<t_change<<endl;
    cout<<"\nYour New Rating will be " << (int)(myrating+t_change) <<endl;
    cout<<"\n*** \t \t End of Report    \t \t ***\n"<<endl;
    infile.close();
} /* end of game_record::list */

void game_record::read_data()
{
    cout<<"\nOpponents Name: ";
    cin>>name;
    cout<<"Opponents club: ";
    cin>>club;
    cout<<"Competition: ";
    cin>>competition;
    cout<<"Opponents Rating: ";
    cin>>opponent_rating;
    cout<<"Game Result: ";
    cin>>result;
    cout<<endl;
} /* end of game_record::read_data */

void game_record::show_data(int game)
{
    cout<<"Game:\t\t"<<game<<endl;
    cout<<"Opponent:\t"<<name<<endl;
    cout<<"Club: \t\t"<<club<<endl;
    cout<<"Competition:\t"<<competition<<endl;
    cout<<"Rating:\t\t"<<opponent_rating<<endl;
    cout<<"Result:\t\t"<<result<<endl;
    cout<<"-------------------------------------------"<<endl;
} /* end of show_data */

void game_record::write_record()
{
    ofstream outfile;
    outfile.open(filename, ios::binary|ios::app);
    read_data();
    outfile.write(reinterpret_cast<char *>(this), sizeof(*this));
    outfile.close();
} /* end of write_record */

/* Read the records one by one and list them on the screen*/
void game_record::read_record()
{   int game = 0;
    ifstream infile;
    infile.open(filename, ios::binary);
    if(!infile)
    {
        cout<<"Error in Opening! "<< filename <<" File Not Found!!"<<endl;
        return;
    }
    cout<<"\n*******************************************"<<endl;
    cout<<"*** Records Listed on the File System   ***"<<endl;
    cout<<"*******************************************"<<endl;
    cout<<"-------------------------------------------"<<endl;
    while(!infile.eof())
    {
	game++;
        if(infile.read(reinterpret_cast<char*>(this), sizeof(*this))>0)
        {
            show_data(game);
        }
    } /* end of while loop */
    infile.close();
    cout<<"*******************************************"<<endl;
    cout<<"***   End of List Records in the file   ***"<<endl;
    cout<<"*******************************************"<<endl;
} /* end of read_record */

void game_record::search_record()
{
    int n;
    ifstream infile;
    infile.open(filename, ios::binary);
    if(!infile)
    {
        cout<<"\nError in opening! File Not Found!!"<<endl;
        return;
    }
    infile.seekg(0,ios::end);
    int count = infile.tellg()/sizeof(*this);
    cout<<"\n There are "<<count<<" record in the file";
    cout<<"\n Enter Game Record Number to Search: ";
    cin>>n;
    infile.seekg((n-1)*sizeof(*this));
    infile.read(reinterpret_cast<char*>(this), sizeof(*this));
    show_data(n);
} /* end of search_record */

void game_record::edit_record()
{
    int n;
    fstream iofile;
    iofile.open(filename, ios::in|ios::binary);
    if(!iofile)
    {
        cout<<"\nError in opening! File Not Found!!"<<endl;
        return;
    }
    iofile.seekg(0, ios::end);
    int count = iofile.tellg()/sizeof(*this);
    cout<<"\n There are "<<count<<" games recorded in the file";
    cout<<"\n Enter Game Record Number to edit: ";
    cin>>n;
    iofile.seekg((n-1)*sizeof(*this));
    iofile.read(reinterpret_cast<char*>(this), sizeof(*this));
    cout<<"Game "<<n<<" has following data"<<endl;
    show_data(n);
    iofile.close();
    iofile.open(filename, ios::out|ios::in|ios::binary);
    iofile.seekp((n-1)*sizeof(*this));
    cout<<"\nEnter data to Modify "<<endl;
    read_data();
    iofile.write(reinterpret_cast<char*>(this), sizeof(*this));
} /* end of edit_record */

void game_record::delete_record()
{
    int n;
    ifstream infile;
    infile.open(filename, ios::binary);
    if(!infile)
    {
        cout<<"\nError in opening! File Not Found!!"<<endl;
        return;
    }
    infile.seekg(0,ios::end);
    int count = infile.tellg()/sizeof(*this);
    cout<<"\n There are "<<count<<" record in the file";
    cout<<"\n Enter Game Record Number to Delete: ";
    cin>>n;
    fstream tmpfile;
    tmpfile.open("tmpfile.rec", ios::out|ios::binary);
    infile.seekg(0);
    for(int i=0; i<count; i++)
    {
        infile.read(reinterpret_cast<char*>(this),sizeof(*this));
        if(i==(n-1))
            continue;
        tmpfile.write(reinterpret_cast<char*>(this), sizeof(*this));
    } /* end of for loop */
    infile.close();
    tmpfile.close();
    remove(filename.c_str());
    rename("tmpfile.rec", filename.c_str());
} /* end of delete record */


int main()
{
    game_record A;
    int choice;
    cout<<"\n*******************************************";
    cout<<"*** Chess Rating and Game Record System ***"<<endl;
    cout<<"\n*******************************************";
    while(true)
    {   /* Menu System */
	cout<<"\n*******************************************";
	cout<<"\n*                                         *";
        cout<<"\n*   Chess Rating and Game Record System   *";
	cout<<"\n*                                         *";
        cout<<"\n*  Select one option below                *";
	cout<<"\n*                                         *";
        cout<<"\n*     1 - Add a Game                      *";
        cout<<"\n*     2 - Show Games                      *";
        cout<<"\n*     3 - Search Games                    *";
        cout<<"\n*     4 - Update Game                     *";
        cout<<"\n*     5 - Delete Game                     *";
        cout<<"\n*     6 - Generate Report                 *";
        cout<<"\n*     0 - Quit                            *";
	cout<<"\n*                                         *";
	cout<<"\n*******************************************";
        cout<<"\nEnter your choice: ";
        cin>>choice;
        switch(choice)
        {
            case 1:
                A.write_record();
                break;
            case 2:
                A.read_record();
                break;
            case 3:
                A.search_record();
                break;
            case 4:
                A.edit_record();
                break;
            case 5:
                A.delete_record();
                break;
            case 6:
                A.generate_report();
                break;
            case 0:
                exit(0);
                break;
            default:
                cout<<"\nEnter a correct number choice";
                exit(0);
        } /* end of switch */
    } /* end of while */
    cout<<"*** End of Chess Rating and Game Record System ***"<<endl;
    system("pause");
    return 0;
}
