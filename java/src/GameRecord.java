package ratings;
import java.util.*;
import java.text.DecimalFormat;

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
		return "" + game + "\t" + player + "\t" + club + "\t" + formatDouble(rating) + "\t" + formatDouble(result) + ":";
	}

	public String formatDouble(Double d){
		DecimalFormat df = new DecimalFormat("####0.00");
		return df.format(d);
	}

	public String toString()
	{
		return "Match Info " + "\n" +
		"Game          = " + game + "\n" +
		"Player        = " + player + "\n" +
		"Club          = " + club + "\n" +
		"Rating        = " + formatDouble(rating) + "\n" +
		"Result        = " + formatDouble(result) + "\n" ;
	}
}

