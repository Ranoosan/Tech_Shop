using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace w2
{
    public partial class ViewOrders : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProductList();
            }
        }

        private void BindProductList()
        {
            // Get connection string from web.config
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;

            // SQL query to retrieve orders
            string query = "SELECT OrderID, ProductID, Quantity, Supplier, CustomerName, CustomerEmail, OrderDate, Status  FROM Orders2";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        connection.Open();
                        SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                        DataTable dataTable = new DataTable();
                        dataAdapter.Fill(dataTable);

                        // Bind the DataTable to the GridView
                        GridViewOrders.DataSource = dataTable;
                        GridViewOrders.DataBind();
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions
                        Response.Write("<script>alert('Error loading orders: " + ex.Message + "');</script>");
                    }
                }
            }
        }
    }
}
