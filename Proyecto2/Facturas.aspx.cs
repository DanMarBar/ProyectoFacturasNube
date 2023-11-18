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
            BindData(dt);
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
        BindData(dt);
    }

    /**
     * Pre:---
     * Post: Cuando click a botón de filtrar se lee otra vez el fichero xml,
     * filtrar por AplicarFiltros() y meter a GridView.
     *
     */
    protected void btnFiltrar(object sender, EventArgs e)
    {
        string fNombre = filtrarNombre.Text;
        string lEstado = listaEstados.SelectedValue;
        if (!string.IsNullOrEmpty(fNombre)) filtroNombre(fNombre);
        if (!string.IsNullOrEmpty(lEstado)) filtroEstado(lEstado);
        if (!string.IsNullOrEmpty(importeMax.Text) | !string.IsNullOrEmpty(importeMin.Text)) filtroImporte(importeMin.Text, importeMax.Text);
    }

    private void filtroImporte(string iMin, string iMax)
    {
        decimal.TryParse(iMin, out decimal importeMin);
        decimal.TryParse(iMax, out decimal importeMax);
        DataTable tFiltro = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter($"select * from facturas Where importe < @importeMax and importe > @importeMin", con);
        da.SelectCommand.Parameters.AddWithValue("@importeMax", importeMax);
        da.SelectCommand.Parameters.AddWithValue("@importeMin", importeMin);
        da.Fill(tFiltro);
        BindData(tFiltro);
    }

    private void filtroEstado(string lEstado)
    {
        DataTable tFiltro = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter($"select * from facturas Where estado like @lEstado", con);
        da.SelectCommand.Parameters.AddWithValue("@lEstado", $"%{lEstado}");
        da.Fill(tFiltro);
        BindData(tFiltro);
    }

        private void filtroNombre(string fNombre)
    {
        DataTable tFiltro = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM facturas WHERE nombre LIKE @fNombre", con);
        da.SelectCommand.Parameters.AddWithValue("@fNombre", $"%{fNombre}%");
        da.Fill(tFiltro);
        BindData(tFiltro);
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
        BindData(dt);
    }

    protected void informacion_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        informacion.EditIndex = -1;
        BindData(dt);
    }

    protected void informacion_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        Label codFactura = informacion.Rows[e.RowIndex].FindControl("numeroFactura") as Label;
        TextBox nombre = informacion.Rows[e.RowIndex].FindControl("txt_nombre") as TextBox;
        TextBox apellidos = informacion.Rows[e.RowIndex].FindControl("txt_apellidos") as TextBox;
        SqlCommand cmd = new SqlCommand($"UPDATE facturas set nombre = '{nombre.Text}', apellidos = '{apellidos.Text}' where numeroFactura = '{codFactura.Text}'",con);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        informacion.EditIndex = -1;
        BindData(dt);
    }

    private void BindData(DataTable newTable)
    {
        informacion.DataSource = newTable;
        informacion.DataBind();
    }
}
