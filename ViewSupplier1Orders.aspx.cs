using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace w2
{
    public partial class ViewSupplier1Orders : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;
            string query = "SELECT OrderID, ProductID, Quantity, CustomerName, CustomerEmail, OrderDate, Status FROM Orders2 WHERE Supplier = 'Supplier1'";

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

                        GridViewOrders.DataSource = dataTable;
                        GridViewOrders.DataBind();
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Error loading orders: " + ex.Message + "');</script>");
                    }
                }
            }
        }

        protected void GridViewOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                // Retrieve OrderID and new Status from the GridView
                int orderId = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");
                string newStatus = ddlStatus.SelectedValue;

                UpdateOrderStatus(orderId, newStatus);
            }
        }

        private void UpdateOrderStatus(int orderId, string newStatus)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;
            string query = "UPDATE Orders2 SET Status = @Status WHERE OrderID = @OrderID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Status", newStatus);
                    command.Parameters.AddWithValue("@OrderID", orderId);

                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        LoadOrders(); // Reload the grid after updating status
                        Response.Write("<script>alert('Order status updated successfully!');</script>");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Error updating order status: " + ex.Message + "');</script>");
                    }
                }
            }
        }
    }
}
