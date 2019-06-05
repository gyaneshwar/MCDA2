import java.io.File;
import java.io.IOException;
import java.util.*;

public class DB
{
    private static int numOfDimensions;
    private static int numOfClusters;
    private static int[]numOfObjects;
    private static double[]clusterDensity;
    private static double[][][]objects; // complete data
    private static double[][]centroid;
    private static double[][]centrCentrDist;
    private static double maxCentrCentrDist;
    private static double[][]objCentrDist;
    private static double[][]R;
    private static double [] Rmax;
    private static double DBindex;
    
    static double distance(double [] x, double [] y)
    {
          double tempDist = 0.0;
          for( int k = 0; k < numOfDimensions; k++)
          {
                    
                tempDist = tempDist + (x[k] - y[k]) * 
                                              (x[k] - y[k]);
          }
          return Math.sqrt(tempDist);
    }

    public static void getDistanceBetweenCentroids()
    {
        centrCentrDist = new double [numOfClusters][numOfClusters];
        for(int i = 0; i < numOfClusters; i++)
        {
            for(int j = i+1; j < numOfClusters; j++)
            {
                centrCentrDist[i][j] = distance(centroid[i],centroid[j]);
            }
            centrCentrDist[i][i] = 0;
        }
        for(int i = 0; i < numOfClusters; i++)
        {
            for(int j = 0; j < i; j++)
            {
                centrCentrDist[i][j] = centrCentrDist[j][i];
            }
        }
    }

    public static void getCentroids()
    {
         centroid = new double [numOfClusters][numOfDimensions];
         for(int i = 0; i < numOfClusters; i++)
         {
            for( int k = 0; k < numOfDimensions; k++)
                centroid[i][k] = 0;
            for( int j = 0; j < numOfObjects[i]; j++)
            {
                for( int k = 0; k < numOfDimensions; k++)
                    centroid[i][k] += objects[i][j][k];
            }
            for( int k = 0; k < numOfDimensions; k++)
                centroid[i][k] /= numOfObjects[i];
        }
    }

    public static void readFileData()
    {
         try{
             Scanner fileScan = new Scanner(System.in);
             System.out.print("Number of dimensions? ");
             numOfDimensions = fileScan.nextInt();
             System.out.print("Number of clusters? ");
             numOfClusters = fileScan.nextInt();
             numOfObjects = new int[numOfClusters];
             objects  = new double[numOfClusters][][];
             objCentrDist  = new double[numOfClusters][];
             for(int i = 0; i < numOfClusters; i++)
             {
                System.out.print("Number of objects in cluster " + i + "? ");
                numOfObjects[i] = fileScan.nextInt();
                System.out.println("Please input " + numOfObjects[i] + 
                " number of objects in cluster " + i + " one per line:");
                objects[i] = new double[numOfObjects[i]][numOfDimensions];
                objCentrDist[i] = new double[numOfObjects[i]];
                for( int j = 0; j < numOfObjects[i]; j++)
                {
                    for( int k = 0; k < numOfDimensions; k++)
                    {
                        objects[i][j][k] = fileScan.nextDouble();
                    }
                }
              }
            }
            catch(Exception e)
            {
               System.out.println(" the error" +e);
            }
    }

    public static void getClusterDensity()
    {
        clusterDensity = new double[numOfClusters];
        for(int i = 0; i < numOfClusters; i++)
        {
            clusterDensity[i] = 0;
            for( int j = 0; j < numOfObjects[i]; j++)
            {
                objCentrDist[i][j] = distance(centroid[i],objects[i][j]);
                clusterDensity[i] += objCentrDist[i][j];
            }
            clusterDensity[i] /= numOfObjects[i];
        }
    }

    public static void calcDB()
    {
        R = new double[numOfClusters][numOfClusters];
        Rmax = new double[numOfClusters];
        DBindex = 0;
        for(int i = 0; i < numOfClusters; i++)
        {
            Rmax[i] = 0;
            for(int j = 0; j < numOfClusters; j++)
            {
                if(i != j)
                {
                    R[i][j] = (clusterDensity[i] + clusterDensity[j])/centrCentrDist[i][j];
                    if(Rmax[i] < R[i][j])
                        Rmax[i] = R[i][j];
                }
            }
            DBindex += Rmax[i];
        }
        DBindex /= numOfClusters;
    }

    public static void printResults()
    {
        for(int i = 0; i < numOfClusters; i++)
        {
            System.out.println("\nCLUSTER " + i + " objects:");
            for(int j = 0; j < numOfObjects[i]; j++)
            {
                for(int k = 0; k < numOfDimensions; k++)
                    System.out.printf("%.3f ", objects[i][j][k]);
                System.out.println();
            }
            System.out.println("Cluster centroid:");
            for(int j = 0; j < numOfDimensions; j++)
                System.out.printf("%.3f ", centroid[i][j]);
            System.out.println();
            System.out.println("Distance between objects and centroid");
            for(int j = 0; j < numOfObjects[i]; j++)
            {
                System.out.printf("d[%d] = %.3f\n", j, objCentrDist[i][j]);
            }
            System.out.printf("Cluster density for cluster %d  = %.3f\n",
            i, clusterDensity[i]);
        }
        System.out.println("\nDistance between clusters:");
        for(int i = 0; i < numOfClusters; i++)
        {
            for(int j = 0; j < numOfClusters; j++)
            {
                System.out.printf("M[%d][%d] = %.3f ", i, j, centrCentrDist[i][j]);
            }
            System.out.println();
        }
        System.out.println("\nCalculations of R and Rmax:");
        for(int i = 0; i < numOfClusters; i++)
        {
            for(int j = 0; j < numOfClusters; j++)
            {
                System.out.printf("R[%d][%d] = %.3f ", i, j, R[i][j]);
            }
            System.out.printf("\nRmax for cluster %d = %.3f\n", i, Rmax[i]);
        }
        
        System.out.printf("\nDB index = %.3f\n\n", DBindex);
    }

    public static void main( String [] v)
    {
        readFileData();
        getCentroids();
        getDistanceBetweenCentroids();
        getClusterDensity();
        calcDB();
        printResults();
    }
}
