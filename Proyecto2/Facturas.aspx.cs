using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using ClickHouse.Ado;


public partial class Facturas : System.Web.UI.Page
{
    static String cs = "Host = ProjectDataBase2; Port=8123; database = default; User=default; Password=BJfMSfgoAOj4.;";
    public DataTable dt = new DataTable();
    public DataView dv = new DataView();
    /**
     * Pre:---
     * Post: Cuando se carga la página se lee los datos de fichero .xml y meter a GridView.
     * GetDataTableFromXml() para lee fichero .xml y se guarda en un DataTable.
     *
     */

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ClickHouseConnection connection = new ClickHouseConnection(cs);
            connection.Open();

            ClickHouseCommand cmd = connection.CreateCommand();
            cmd.CommandText = "SELECT * FROM Facturas";
            ClickHouseDataReader reader = (ClickHouseDataReader)cmd.ExecuteReader();
            DataTable dataTable = new DataTable();
            dataTable.Load(reader);
            informacion.DataSource = dataTable;
            informacion.DataBind();
        }
    }
    /**
     * Pre:---
     * Post: Cuando click a botón de restablecer se vacia los filtros y GridView devolver a su estado original.
     *
     */
    //protected void Page_Reload(object sender, EventArgs e)
    //{
    //    SqlDataAdapter da = new SqlDataAdapter("select * from Facturas", con);
    //    da.Fill(dt);
    //    informacion.DataSource = dt;
    //    informacion.DataBind();
    //    Session["TaskTable"] = dt;
    //}

    /**
     * Pre:---
     * Post: Cuando click a botón de filtrar se lee otra vez el fichero xml,
     * filtrar por AplicarFiltros() y meter a GridView.
     *
     */
    //protected void btnFiltrar(object sender, EventArgs e)
    //{
    //    string xmlFilePath = Server.MapPath("~/Datos/Facturas.xml");
    //    dt = GetDataFromBBDD(xmlFilePath);
    //    AplicarFiltro();
    //    informacion.DataSource = dt;
    //    informacion.DataBind();
    //}

    /**
     * Pre:---
     * Post: Leer los datos que tiene en el fichero xml y guardar en una DataTable.
     *
     */
    //private DataTable GetDataFromBBDD(string xmlFilePath)
    //{
    //    DataTable dataTable = new DataTable();
    //    try
    //    {
    //        XmlDocument xmlDoc = new XmlDocument();
    //        xmlDoc.Load(xmlFilePath);
    //        XmlNode firstNode = xmlDoc.DocumentElement.FirstChild;
    //        foreach (XmlNode node in firstNode.ChildNodes)
    //        {
    //            dataTable.Columns.Add(node.Name, typeof(string));
    //        }
    //        foreach (XmlNode node in xmlDoc.DocumentElement.ChildNodes)
    //        {
    //            DataRow row = dataTable.NewRow();
    //            foreach (XmlNode childNode in node.ChildNodes)
    //            {
    //                if (!dataTable.Columns.Contains(childNode.Name))
    //                    dataTable.Columns.Add(childNode.Name, typeof(string));
    //                row[childNode.Name] = childNode.InnerText;
    //            }
    //            dataTable.Rows.Add(row);
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        Console.WriteLine("Ocurrió un error al leer el archivo XML: " + ex.Message);
    //    }

    //    return dataTable;
    //}

    /**
     * Pre:---
     * Post: Filtrar por datos que quiere filtrar con DataView.
     * Se cambia los datos que estan en la DataTable por los datos filtrados.
     *
     */
    private void AplicarFiltro()
    {
        string fNombre = filtrarNombre.Text;
        string lEstado = listaEstados.SelectedValue;
        dv = new DataView(dt);
        if (!string.IsNullOrEmpty(fNombre) && !string.IsNullOrEmpty(lEstado))
        {
            dv.RowFilter = $"nombre LIKE '%{fNombre}%' AND estado LIKE '{lEstado}'";
        }
        else if (!string.IsNullOrEmpty(fNombre))
        {
            dv.RowFilter = $"nombre LIKE '%{fNombre}%'";
        }
        else if (!string.IsNullOrEmpty(lEstado))
        {
            dv.RowFilter = $"estado LIKE '{lEstado}'";
        }
        else
        {
            // Si no hay filtro, muestra todos los datos
            dv.RowFilter = "";
        }
        dt = dv.ToTable();
    }

    /**
     * Pre:---
     * Post: Exportar los datos que tiene en GridView a fichero .xsl.
     *
     */
    protected void btnCommit(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=exported_data.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        AplicarFiltro();
        GridView gvExport = new GridView();
        gvExport.DataSource = dt;
        gvExport.DataBind();
        gvExport.RenderControl(hw);
        Response.Output.Write(sw.ToString());
        Response.Flush();
        Response.End();
    }

    protected void informacion_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        informacion.PageIndex = e.NewPageIndex;
        //Bind data to the GridView control.
        BindData();
    }

    protected void informacion_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //Set the edit index.
        informacion.EditIndex = e.NewEditIndex;
        //Bind data to the GridView control.
        BindData();
    }

    protected void informacion_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        //Reset the edit index.
        informacion.EditIndex = -1;
        //Bind data to the GridView control.
        BindData();
    }

    protected void informacion_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //Retrieve the table from the session object.
        DataTable dt = (DataTable)Session["TaskTable"];

        //Update the values.
        GridViewRow row = informacion.Rows[e.RowIndex];
        dt.Rows[row.DataItemIndex]["importe"] = ((TextBox)(row.Cells[7].Controls[0])).Text;
        dt.Rows[row.DataItemIndex]["apellidos"] = ((TextBox)(row.Cells[4].Controls[0])).Text;
        dt.Rows[row.DataItemIndex]["nombre"] = ((TextBox)(row.Cells[3].Controls[0])).Text;

        //Reset the edit index.
        informacion.EditIndex = -1;

        //Bind data to the GridView control.
        BindData();
    }

    private void BindData()
    {
        informacion.DataSource = Session["TaskTable"];
        informacion.DataBind();
    }
}
