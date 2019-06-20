using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
namespace Flattern
{
    public class Flat
    {
        public static void Main(string[] args)
        {
            using (var x = new StreamReader(args[0]))
            {
                //product transaction
                Dictionary<String, String> obj = new Dictionary<String, String>();
                string item = "";
                while ((item = x.ReadLine()) != null)
                {
                    var items = item.ToString().Split('\t');
                    if (obj.ContainsKey(items[0]))
                    {
                        obj[items[0]] += " " + items[1];
                    }
                    else
                    {
                        obj.Add(items[0], items[1]);
                    }
                }
                using (var y = new StreamWriter("output.txt"))
                {
                    foreach (var lc in obj)
                    {
                        String z = lc.Key + " " + lc.Value;
                        y.WriteLine(z);
                    }
                }
            }
        }
    }
}

