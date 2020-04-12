using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Xml;
using System.Xml.Linq;
using Path = System.IO.Path;

namespace Configurator
{
    
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private const string SchemaXml = "schema.xml";
        private string _selPath;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void OpenFolderMenu_OnClick(object sender, RoutedEventArgs e)
        {
            _selPath = GetFolderPath();
            if (_selPath != "")
            {
                OpenFolder();
            }
        }

        private void OpenFolder()
        {
            LoadSchema();
        }

        private void LoadSchema()
        {
            string schemaName = Path.Combine(_selPath, SchemaXml);
            XmlDataProvider schemaProvider = new XmlDataProvider();
            if(File.Exists(schemaName))
            { 
                XmlDocument schemaDocument = new XmlDocument(); 
                schemaDocument.Load(schemaName);
                schemaProvider.Document = schemaDocument;
                schemaProvider.XPath = "/schema";
                SchemaTree.DataContext = schemaProvider;
            }
            else
            { }
        }

        private static string GetFolderPath()
        {
            var dialog = new Ookii.Dialogs.Wpf.VistaFolderBrowserDialog();
            dialog.SelectedPath = System.AppDomain.CurrentDomain.BaseDirectory;
            dialog.ShowDialog();
            return dialog.SelectedPath;
        }
    }
}
