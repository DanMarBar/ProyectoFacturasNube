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
using System.Globalization;

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
     * Post: elimina los filtros escritos
     * 
     * @Author: Daniel Martinez
     * @Date: 19-11-2023
     */
    private void LimpiarFiltros()
    {
        filtrarNombre.Text = String.Empty;
        importeMin.Text = String.Empty;
        importeMax.Text = String.Empty;
        listaEstados.SelectedIndex = 0; 
    }

    /**
     * Pre:---
     * Post: Después de hacer clic en el botón Restablecer, el filtro se borrará y el GridView volverá a su estado inicial.
     * 
     * @Author: Hongbin Ruan
     * @Date: 18-11-2023
     */
    protected void Reload_Table(object sender, EventArgs e)
    {
        dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter("select * from facturas", con);
        da.Fill(dt);
        filtrotable = new DataTable();
        filtrotable = dt.Copy(); 
        BindData(dt);
        lblError.Text = "";
        LimpiarFiltros();
    }

    /**
     * Pre:---
     * Post: Después de hacer clic en el botón Restablecer, el filtro se borrará y el GridView volverá a su estado inicial.
     * Es en donde se ejecutan los filtros, los cuales se añaden a una lista, la cual al final los usara para la Query. Se
     * preveen errores a la hora de la insercion de los parametros por parte del usuario. 
     * 
     * @Author: Hongbin Ruan
     * @Date: 18-11-2023
     */
    protected void btnFiltrar(object sender, EventArgs e)
    {
        try
        {
            decimal.TryParse(importeMin.Text, out decimal iMin);
            decimal.TryParse(importeMax.Text, out decimal iMax);
            DataView dataView = new DataView(dt);
            filtros.Clear();

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
                filtros.Add($"importe >= {iMin}");
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
            lblError.Text = "";
        }
        catch (System.Data.SyntaxErrorException ex)
        {
            lblError.Text = "Error al aplicar el filtro. Por favor, revisa los criterios de búsqueda.";
            System.Diagnostics.Debug.WriteLine("Error al filtrar: " + ex.Message);
        }
        catch (Exception ex)
        {
            lblError.Text = "Error mayor";
            System.Diagnostics.Debug.WriteLine("Error al filtrar: " + ex.Message);
        }
    }

    /**
     * Pre:---
     * Post: Obtener el row que quires editar.
     * 
     * @Author: Hongbin Ruan
     * @Date: 18-11-2023
     */
    protected void informacion_RowEditing(object sender, GridViewEditEventArgs e)
    {
        informacion.EditIndex = e.NewEditIndex;
        if (filtros.Count > 0) BindData(filtrotable);
        else BindData(dt);
    }

    /**
     * Pre:---
     * Post: Anulación de la insercion de los datos para realizar el update
     *
     * @Author: Hongbin Ruan
     * @Date: 18-11-2023
     */
    protected void informacion_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        informacion.EditIndex = -1;
        BindData(filtrotable);
    }

    /**
     * Pre:---
     * Post: Obtención de información actualizada, actualización de la información de la base de datos 
     * y recuperación de la información actualizada de la base de datos. Transforma los datos que sean
     * necesarios y los actualiza. Se prevee que el usuario introduzca algun caracter invalido y la 
     * sitacion esta controlada
     * 
     * @Author: Hongbin Ruan
     * @Date: 18-11-2023
     */
    protected void informacion_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
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
            string fechaCobroString = fechaCobro.Text.Trim();
            DateTime fechaCobroValue;
            if (DateTime.TryParseExact(fechaCobroString, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fechaCobroValue))
            {
                string fechaFormateada = fechaCobroValue.ToString("MM/dd/yyyy");
                fechaCobro.Text = fechaFormateada;
            }
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
                BindData(filtrotable);
            }
            else BindData(dt);
            lblError.Text = "";
        }
        catch (System.Data.SqlClient.SqlException ex)
        {
            System.Diagnostics.Debug.WriteLine("SQL Error: " + ex.Message);
            lblError.Text = "Error al actualizar la base de datos SQL Error: " + ex.Message;
        }
        catch (System.InvalidOperationException ex)
        {
            System.Diagnostics.Debug.WriteLine("InvalidOperationException: " + ex.Message);
        }
        finally
        {
            con.Close();
        }
    }

    /**
     * Pre: ---
     * Post: Se encarga de cambiar el color de fondo de la fila que se está editando 
     * a un tono PaleVioletRed para destacarla. Además, ajusta el valor seleccionado 
     * en un DropDownList dentro de la fila en edición, basándose en el estado actual 
     * de esa fila.
     * 
     * @Author: Daniel Martinez
     * @Date: 19-11-2023
     */
    protected void informacion_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.RowIndex == informacion.EditIndex)
            {
                e.Row.BackColor = System.Drawing.Color.PaleVioletRed; 
            }
            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("txt_estados");
                string estadoActual = DataBinder.Eval(e.Row.DataItem, "estado").ToString();
                ddl.SelectedValue = estadoActual;
            }
        }
    }

    /**
     * Pre:---
     * Post: Visualización de datos de la DataTable
     * 
     * @Params newTable la tabla a ser visualizada
     * @Author: Hongbin Ruan
     * @Date: 18-11-2023
     */
    private void BindData(DataTable newTable)
    {
        informacion.DataSource = newTable;
        informacion.DataBind();
    }
}
