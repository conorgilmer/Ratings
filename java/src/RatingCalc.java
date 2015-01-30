/* RatingCalc.java 
 * by Conor Gilmer (conor.gilmer@gmail.com)
 */

package ratings;
import java.util.Scanner;
import java.io.*;

public final class RatingCalc {
	/* initialise variables */
	public static String player      = " ";
	public static String club        = " ";
	public static double rating      = 0;
	public static double result      = 0;
	public static double yourrating  = 1650;
	public static double change      = 0;
	public static double extra       = 0;
	public static String inputFile   = "results.csv";
	public static String outputFile  = "report.out";

	private static final String [] FILE_HEADER_MAPPING = {"id","player","club","rating","result"};
     

 
	/* display a line of text to screen */
	private static void display(String text ) {
		System.out.println(text);
	} /* end of display */

	/* display a double number */
	private static void displayf(double num) {
		System.out.format("%.2f", num);
	} /* end of displayf */

	private static double calculateChange(double yours, double opponents, double result) {
		double change = 0;
		double rdiff = opponents - yours;
		
		if (result == 1) {
			change = (((rdiff / 100) * 4) + 16);
			if (change <= 0) {
				change = 0;
			}
		} else if (result == 0.5) {
			change = (rdiff / 100) * 4;
		} else if (result == 0) {
			change = (((rdiff / 100) * 4) - 16);
			if (change >= 0) {
				change = 0;
			}

		} else {display(" NO GAME RESULT");}


		return change;
	
	} /* end of calculateChange */


	/* read from a file and print on screen */
	private static void readFile(String filename) {
		try {
            		File dataFile         = new File(filename);
			FileReader fileReader = new FileReader(dataFile);
			BufferedReader reader = new BufferedReader(fileReader);
			//BufferedReader reader = new BufferedReader(new FileReader(new File(filename)));
    			String line = null;
			String [] splitArray; 
			int games =0;
			double avgr =0;
			double change =0;
			double total_change =0;
			double results =0;
			display("Contents of " + filename + "\n");
    			while ((line = reader.readLine()) != null) {
				splitArray = line.split(",");
				GameRecord record = new GameRecord(Integer.parseInt(splitArray[0]),
							splitArray[1],
							splitArray[2],
							Double.parseDouble(splitArray[3]),
							Double.parseDouble(splitArray[4]));
				results = results + Double.parseDouble(splitArray[4]);
				avgr = avgr + Double.parseDouble(splitArray[3]);
				change = calculateChange(yourrating, Double.parseDouble(splitArray[3]), Double.parseDouble(splitArray[4]));
				total_change = total_change + change;
				games++;
				display(record.toLine() + "\t" + change);
    			}
			display("\nEnd of " + filename + "\n");
			avgr = avgr/games;

			Results season = new Results(games, avgr, total_change, results);
			display(season.toString());
		} catch (IOException x) {
    			System.err.format("IOException: %s%n", x);
		}
		
	} /* end of readFile */


	/* Main Function */
	public static void main (String[] args) {

		display("\n *** Starting ***\n");
		readFile("results.csv");
		display("\n *** The End  *** \n");
	} /* end of main */

} /* end of prog */

