#include <iostream>
 
using namespace std;
 
int main()
{
  int yourrating;
  int opponent;
  double rdiff;
  char result;
  double change = 0;
 
  cout<<"What is your rating  : " << endl;
  cin>> yourrating;
  cout<<"What was your opponents rating  : " << endl;
  cin>> opponent;
  cout<<"What was the result w-win, d-draw, and l-loss  : " << endl;
  cin>> result;

  rdiff = (opponent - yourrating) /25.0;
  if(result == 'w' || result =='W') 
  {
	cout<<"Congrats you won\n" << endl;
	change = 16 + rdiff;
	if (change  <= 0.0)
	{
		change = 0.0;
	}
  }
  else if(result == 'd' || result =='D') 
  {
	cout<<"Not so Bad\n" << endl;
	change = rdiff;
  }
  else if(result == 'l' || result =='L') 
  {
	cout<<"Hard Luck\n" << endl;
	change = -16 + rdiff;
  } else {
	cout<<"That isnt a result\n" << endl;
  }
  yourrating = (int)change + yourrating;
  cout<<"Your rating will change by "<< change <<"\n" << endl;
  cout<<"Your new rating will be  "<< yourrating <<"\n" << endl;
}
