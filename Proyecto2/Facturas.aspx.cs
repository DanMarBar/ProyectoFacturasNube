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
using MySql.Data.MySqlClient;

public partial class Facturas : System.Web.UI.Page
{
    static String cs = ConfigurationManager.ConnectionStrings["cloud"].ConnectionString;
    static SqlConnection con = new SqlConnection(cs);
    static public DataTable dt = new DataTable();
    static public DataView dv = new DataView();
    public static MySqlConnectionStringBuilder NewMysqlTCPConnectionString()
    {
        // Equivalent connection string:
        // "Uid=<DB_USER>;Pwd=<DB_PASS>;Host=<INSTANCE_HOST>;Database=<DB_NAME>;"
        var connectionString = new MySqlConnectionStringBuilder()
        {
            // Note: Saving credentials in environment variables is convenient, but not
            // secure - consider a more secure solution such as
            // Cloud Secret Manager (https://cloud.google.com/secret-manager) to help
            // keep secrets safe.
            Server = Environment.GetEnvironmentVariable("127.0.0.1"),   // e.g. '127.0.0.1'
                                                                            // Set Host to 'cloudsql' when deploying to App Engine Flexible environment
            UserID = Environment.GetEnvironmentVariable("projectfactura"),   // e.g. 'my-db-user'
            Password = Environment.GetEnvironmentVariable("{:oZ&gt;=c81xgH^}4_"), // e.g. 'my-db-password'
            Database = Environment.GetEnvironmentVariable("BBDDCloud"), // e.g. 'my-database'

            // The Cloud SQL proxy provides encryption between the proxy and instance.
            SslMode = MySqlSslMode.Disabled,
        };
        connectionString.Pooling = true;
        // Specify additional properties here.
        return connectionString;
    }
    /**
     * Pre:---
     * Post: Cuando se carga la página se lee los datos de fichero .xml y meter a GridView.
     * GetDataTableFromXml() para lee fichero .xml y se guarda en un DataTable.
     *
     */

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlDataAdapter da = new SqlDataAdapter("select * from facturas", con);
            da.Fill(dt);
            BindData();
        }
    }

    /**
* Pre:---
* Post: Cuando click a botón de restablecer se vacia los filtros y GridView devolver a su estado original.
*
*/
    protected void Reload_Table(object sender, EventArgs e)
    {
        SqlDataAdapter da = new SqlDataAdapter("select * from facturas", con);
        da.Fill(dt);
        BindData();
    }

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
    }

    protected void informacion_RowEditing(object sender, GridViewEditEventArgs e)
    {
        informacion.EditIndex = e.NewEditIndex;
        BindData();
    }

    protected void informacion_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        informacion.EditIndex = -1;
        BindData();
    }

    protected void informacion_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        SqlDataAdapter da = new SqlDataAdapter((string)ViewState["update"], con);
        SqlCommandBuilder db = new SqlCommandBuilder(da);
        DataSet ds = (DataSet)ViewState["dataset"];
        if (ds.Tables["facturas"].Rows.Count > 0) {
            GridViewRow row = informacion.Rows[e.RowIndex];
            DataRow dr = ds.Tables["facturas"].Rows[0];
            dr["importe"] = ((TextBox)(row.Cells[10].Controls[0])).Text;
        }
        informacion.EditIndex = -1;
        BindData();
    }

    private void BindData()
    {
        informacion.DataSource = dt;
        informacion.DataBind();
    }
}
