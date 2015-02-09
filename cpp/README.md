#CPP Chess Games Record System
Based on a college project for students or employees record system, but for chess games with calculating the resulting rating change from a game
+ Add a Game
+ List all Games
+ Search for a Game
+ Update a Game
+ Delete a Game
+ Generate a report - Calculating chess rating from a game using +/- 16 + ((opponents - yours) *25)


## Example
### Menu Screen
>*******************************************
>*                                         *
>*   Chess Rating and Game Record System   *
>*                                         *
>*  Select one option below                *
>*                                         *
>*     1 - Add a Game                      *
>*     2 - Show Games                      *
>*     3 - Search Games                    *
>*     4 - Update Game                     *
>*     5 - Delete Game                     *
>*     6 - Generate Report                 *
>*     0 - Quit                            *
>*                                         *
>*******************************************
>Enter your choice: 0

### Report
>*** 	 	 Report Data from file 	 	 ***
>
>Game	Name	Club	Grade	Result	Rdiff	Change
> 1	Joe	Jcc	1200	W	-450	0
> 2	Pete	HCC	1777	d	127	5.08
> 3	Barry	ICU	1455	d	-195	-7.8
> 4	Declan	COR	1900	W	250	26
> 5	John	KIL	1900	L	250	-6
> 6	Brian	BAL	1871	l	221	-7.16
> 7	Alan	INC	1599	d	-51	-2.04
>
>	Average		1671.71	3.5	Change	8.08
>
>Your New Rating will be 1658
>
>*** 	 	 End of Report    	 	 ***




##Done
+ user input dialog
+ calculate rating change
+ limit loss of rating due to a win 
+ calculate averages

##To Do
+ read/write to/from a csv file rather than binary
+ add icu code
+ allow for full names i.e. spaces in names

##Colophon
+ g++ compiler used
+ vim editor used
+ gmake builder used
