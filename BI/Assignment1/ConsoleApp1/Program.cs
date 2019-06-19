using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


class Solution
{
    public static int[] solution(int[] A, int K)
    {
        var a = A.ToList();
        var number_of_arrays = a.Count - K +1;
        List<List<int>> x = new List<List<int>>();
        for (int i = 0; i < number_of_arrays; i++)
        {
            var xlocal = new List<int>();
            for (int j = 0; j < K; j++)
            {
                xlocal.Add(a[i + j]);
            }
            x.Add(xlocal);
        }
        foreach (var item in x)
        {
            foreach (var local in item)
            {
                Console.Write(local + ",");
            }
            Console.WriteLine("\n");
        }

        var result = x[0];
        for (int i = 1; i < x.Count; i++)
        {
            result = compare(result, x[i]);
        }
        foreach (var local in result)
        {
            Console.Write(local + ",");
        }
        return result.ToArray();
    }

    public static List<int> compare(List<int> a, List<int> b)
    {
        for (int i = 0; i < a.Count; i++)
        {
            if (a[i] == b[i])
            {
                continue;
            }
            else if (a[i] > b[i])
            {
                return a;
            }
            else
            {
                return b;
            }
        }
        return null;
    }

    public static void Main(string[] args)
    {
        int[] A = new int[] { 1, 4, 3, 2, 5 };
        solution(A, 4);
        //foreach (var item in x)
        //{
        //    Console.WriteLine(item);
        //}
        // Console.WriteLine("hello world");
        Console.ReadKey();
    }
}
