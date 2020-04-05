using System;
using Newtonsoft.Json;
using System.CommandLine;
using System.IO;
using Newtonsoft.Json.Linq;

namespace DOAJSplitter
{
    /// <summary>
    /// Takes a DOAJ archive file and splits into a series of
    /// individual article files
    /// </summary>
    internal class Program
    {
        // see https://docs.microsoft.com/en-us/archive/msdn-magazine/2019/march/net-parse-the-command-line-with-system-commandline
        private static void Main(string[] args)
        {
            var inputFile = args[0];
            var outputDir = args[1];
            if (string.IsNullOrEmpty(outputDir)) outputDir = ".";
            var reader = new JsonTextReader(new StreamReader(inputFile));

            int iCounter = 0;
            while (reader.Read())
                switch (reader.TokenType)
                {
                    case JsonToken.StartArray: //the root level object is an array specification
                        break;
                    case JsonToken.StartObject:
                        var obj = JObject.Load(reader);
                        var writer = new StreamWriter($"{outputDir}/{obj["id"]}.json");
                        writer.Write(obj.ToString());
                        writer.Close();
                        Console.Write($"\rInput file '{inputFile}'; Writing file {++iCounter}      ");
                        break;
                }
        }
    }
}