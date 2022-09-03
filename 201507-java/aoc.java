import java.io.*;

public class aoc {
    public static void main(String args[]) {
        var circuit = new Circuit(readInput());
        var part1 = circuit.RunOne("a");

        System.out.println(part1);

        var part2 = circuit.RunTwo("a", "b");

        System.out.println(part2);
    }

    private static String readInput(){
        try(BufferedReader br = new BufferedReader(new FileReader("input.txt"))) {
            StringBuilder sb = new StringBuilder();
            String line = br.readLine();
        
            while (line != null) {
                sb.append(line);
                sb.append(System.lineSeparator());
                line = br.readLine();
            }
            return sb.toString();
        } catch (Exception e){
            return "";
        }
    }
}