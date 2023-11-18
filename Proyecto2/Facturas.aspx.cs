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

public partial class Facturas : System.Web.UI.Page
{
    static String cs = ConfigurationManager.ConnectionStrings["cloud_connecxion"].ConnectionString;
    static SqlConnection con = new SqlConnection(cs);
    static DataTable dt = new DataTable();
    static DataTable filtrotable = dt;
    static List<string> filtros = new List<string>();

    /**
     * Pre:---
     * Post: Cuando la página se carga, lee los datos de la base de datos y los pone en una tabla de datos.
     * y la muestra mediante BindData().
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
     * Post: Después de hacer clic en el botón Restablecer, el filtro se borrará y el GridView volverá a su estado inicial.
     *
     */
    protected void Reload_Table(object sender, EventArgs e)
    {
        filtrotable = dt;
        dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter("select * from facturas", con);
        da.Fill(dt);
        BindData(dt);
    }

    /**
     * Pre:---
     * Post: Después de pulsar el botón Filtrar
     * Filtrar los datos de la DataTable dt,
     * y en otra DataTable filtertable y mostrarla mediante BindData().
     *
     */
    protected void btnFiltrar(object sender, EventArgs e)
    {
        decimal.TryParse(importeMin.Text, out decimal iMin);
        decimal.TryParse(importeMax.Text, out decimal iMax);
        DataView dataView = new DataView(dt);
        if (!string.IsNullOrEmpty(filtrarNombre.Text) && dt.Columns.Contains("nombre"))
        {
            filtros.Add($"nombre like '%{filtrarNombre.Text}%'");
        }

        if (!string.IsNullOrEmpty(listaEstados.SelectedValue) && dt.Columns.Contains("estado"))
        {
            filtros.Add($"estado like '%{listaEstados.SelectedValue}%'");
        }

        if (dt.Columns.Contains("importe") && (iMin != 0 & iMax != 0))
        { 
            filtros.Add($"importe >= {iMin} AND importe <= {iMax}");
        } 
        else if (dt.Columns.Contains("importe") && (iMin != 0))
        {
            filtros.Add($"importe >= {iMin} ");
        }
        else if (dt.Columns.Contains("importe") && (iMax != 0))
            {
            filtros.Add($"importe <= {iMax}");
        }

        if (filtros.Count > 0)
        {
            dataView.RowFilter = string.Join(" AND ", filtros);
        }
        filtrotable = dataView.ToTable();
        BindData(filtrotable);
    }

    /**
     * Pre:---
     * Post: Obtener el row que quires editar.
     *
     */
    protected void informacion_RowEditing(object sender, GridViewEditEventArgs e)
    {
        informacion.EditIndex = e.NewEditIndex;
        if (filtros.Count > 0) BindData(filtrotable);
        else BindData(dt);
    }

    /**
     * Pre:---
     * Post: Anulación de la modificación
     *
     */
    protected void informacion_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        informacion.EditIndex = -1;
        BindData(filtrotable);
    }

    /**
     * Pre:---
     * Post: Obtención de información actualizada, actualización de la información de la base de datos 
     * y recuperación de la información actualizada de la base de datos.
     * 
     */
    protected void informacion_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        Label codFactura = informacion.Rows[e.RowIndex].FindControl("numeroFactura") as Label;
        TextBox nombre = informacion.Rows[e.RowIndex].FindControl("txt_nombre") as TextBox;
        TextBox apellidos = informacion.Rows[e.RowIndex].FindControl("txt_apellidos") as TextBox;
        TextBox CIF = informacion.Rows[e.RowIndex].FindControl("txt_cif") as TextBox;
        TextBox direccion = informacion.Rows[e.RowIndex].FindControl("txt_direccion") as TextBox;
        TextBox ciudad = informacion.Rows[e.RowIndex].FindControl("txt_ciudad") as TextBox;
        TextBox codPostal = informacion.Rows[e.RowIndex].FindControl("txt_codPostal") as TextBox;
        TextBox importe = informacion.Rows[e.RowIndex].FindControl("txt_importe") as TextBox;
        TextBox fechaCobro = informacion.Rows[e.RowIndex].FindControl("txt_fechaCobro") as TextBox;
        DropDownList estado = informacion.Rows[e.RowIndex].FindControl("txt_estados") as DropDownList;
        int codPostalValue;
        decimal importeValue;
        int.TryParse(codPostal.Text, out codPostalValue);
        decimal.TryParse(importe.Text, out importeValue);
        con.Open();
        string query = "UPDATE facturas SET nombre = @Nombre, apellidos = @Apellidos, CIFCliente = @CIF, direccion = @Direccion, ciudad = @Ciudad, codPostal = @CodPostal," +
            " importe = @Importe, fechaCobro = @FechaCobro, estado = @Estado WHERE numeroFactura = @CodigoFactura";
        SqlCommand command = new SqlCommand(query, con);
            command.Parameters.AddWithValue("@Nombre", nombre.Text);
            command.Parameters.AddWithValue("@Apellidos", apellidos.Text);
            command.Parameters.AddWithValue("@CIF", CIF.Text);
            command.Parameters.AddWithValue("@Direccion", direccion.Text);
            command.Parameters.AddWithValue("@Ciudad", ciudad.Text);
            command.Parameters.AddWithValue("@CodPostal", codPostalValue);
            command.Parameters.AddWithValue("@Importe", importeValue);
            command.Parameters.AddWithValue("@FechaCobro", fechaCobro.Text);
            command.Parameters.AddWithValue("@Estado", estado.SelectedValue);
            command.Parameters.AddWithValue("@CodigoFactura", codFactura.Text);
        command.ExecuteNonQuery();
        con.Close();
        SqlDataAdapter da = new SqlDataAdapter("select * from facturas", con);
        dt = new DataTable();
        da.Fill(dt);
        informacion.EditIndex = -1;
        if (filtros.Count > 0)
        {
            DataView dv = new DataView(dt);
            dv.RowFilter = string.Join(" AND ", filtros);
            filtrotable = dv.ToTable();
            filtros.Clear();
            BindData( filtrotable );
            
        } else BindData(dt);
    }

    /**
     * Pre:---
     * Post: Visualización de datos de la DataTable
     * 
     */
    private void BindData(DataTable newTable)
    {
        informacion.DataSource = newTable;
        informacion.DataBind();
    }
}
