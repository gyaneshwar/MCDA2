public class entropy
{
    public static void main(String [] a)
    {
        int cols = 0;
        for(int i = 3; i <= 20; i++)
        {
            for(int j = 1; j <= i/2; j++)
            {
                double p = 1.0*j/i;
                double h = (p*Math.log10(1/p)+(1-p)*Math.log10(1/(1-p)))/Math.log10(2.0);
                System.out.printf("H(%d,%d)=%.2f\t",j,(i-j),h);
                cols++;
                if(cols == 5)
                {
                    System.out.println();
                    cols = 0;
                }
            }
            System.out.println("\n");
            cols = 0;
        }
    }
}

