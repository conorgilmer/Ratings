package ratings;
import java.util.*;

public class GameRecord
{
	GameRecord(	int    game,
			String player, 
			String club, 
			double rating, 
			double result) 
	{
		this.game      = game; 
		this.player    = player;
		this.club      = club;
		this.rating    = rating;
		this.result    = result;
	}

	int    game; 
	String player; 
	String club; 
	double rating; 
	double result; 

	public int    getGame  ()   { return game;}
	public String getPlayer()   { return player;}
	public String getClub ()    { return club;} 
	public double getRating()   { return rating;} 
	public double getResult()   { return result;} 

	public String toLine()
	{
		return "" + game + "\t" + player + "\t" + club + "\t" + rating + "\t" + result;
	}

	public String toString()
	{
		return "Match Info " + "\n" +
		"Game          = " + game + "\n" +
		"Player        = " + player + "\n" +
		"Club          = " + club + "\n" +
		"Rating        = " + rating + "\n" +
		"Result        = " + result + "\n" ;
	}
}

