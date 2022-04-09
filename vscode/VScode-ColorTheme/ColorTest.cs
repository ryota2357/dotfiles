using System;
using System.Collections;

namespace ColorTest{
    /// <summary>
    ///
    /// </summary>
    public static class Main{
        // public static static void Main(){

            var t = new Tmp();

            int a = 10;
            int b = 20:
            if(a <  b) Console.WriteLine(a);
            string s = "apple";
            string t = "banana";
            if(s.size < t.size) Console.WriteLine("long");
            return;
        }
    }
    sealed class Tmp{

    }


    [[System.AttributeUsage(System.AttributeTargets.All, Inherited = false, AllowMultiple = true)]
    sealed class MyAttribute : System.Attribute
    {
        // See the attribute guidelines at
        //  http://go.microsoft.com/fwlink/?LinkId=85236
        readonly string positionalString;

        // This is a positional argument
        public MyAttribute(string positionalString)
        {
            this.positionalString = positionalString;

            // TODO: Implement code here
            throw new System.NotImplementedException();
        }

        public string PositionalString
        {
            get { return positionalString; }
        }

        // This is a named argument
        public int NamedInt { get; set; }
    }]
}