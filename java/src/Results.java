package ratings;
import java.util.*;
import java.text.DecimalFormat;

/* class for the seasons results and for writing report */
public class Results
{
	Results(	int    games,
			double avgrating, 
			double minR, 
			double maxR, 
			double change, 
			double result) 
	{
		this.games      = games;
		this.avgrating  = avgrating;
		this.minR       = minR;
		this.maxR       = maxR;
		this.change     = change;
		this.result     = result;
	}

	int    games; 
	double avgrating; 
	double minR; 
	double maxR; 
	double change; 
	double result; 

	public int    getGames()     { return games;} 
	public double getAvgRating() { return avgrating;} 
	public double getMinR()      { return minR;} 
	public double getMaxR()	     { return maxR;} 
	public double getChange()    { return change;} 
	public double getResult()    { return result;} 

        public String formatDouble(Double d){
                DecimalFormat df = new DecimalFormat("####0.00");
                return df.format(d);
        }


	public String toString()
	{
		return "Season Info Summary" + "\n" +
		"Games        = " + games + "\n" +
		"AvgRating    = " + avgrating + "\n" +
		"Minimum R    = " + minR + "\n" +
		"Maximim R    = " + maxR + "\n" +
		"Change       = " + formatDouble(change) + "\n" +
		"Results      = " + result + "\n" ;
	}
}

