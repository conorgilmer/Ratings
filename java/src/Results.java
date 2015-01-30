package ratings;
import java.util.*;

public class Results
{
	Results(	int    games,
			double avgrating, 
			double change, 
			double result) 
	{
		this.games      =games;
		this.avgrating      =avgrating;
		this.change      =change;
		this.result    = result;
	}

	int    games; 
	double avgrating; 
	double change; 
	double result; 

	public int    getGames()     { return games;} 
	public double getAvgRating()   { return avgrating;} 
	public double getChange()    { return change;} 
	public double getResult()    { return result;} 

	public String toString()
	{
		return "Season Info Summary" + "\n" +
		"Games        = " + games + "\n" +
		"AvgRating    = " + avgrating + "\n" +
		"Change       = " + change + "\n" +
		"Results      = " + result + "\n" ;
	}
}

