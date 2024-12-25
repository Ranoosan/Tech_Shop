using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace w2
{
    public partial class InventoryManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts(); // Load products into the dropdown
                BindProductList();
                CheckLowStock(); // Check for low stock products
            }
        }

        private void LoadProducts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ProductID, ProductName FROM Products";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlProduct.Items.Clear();
                ddlProduct.Items.Add(new ListItem("Select a Product", ""));
                while (reader.Read())
                {
                    ddlProduct.Items.Add(new ListItem(reader["ProductName"].ToString(), reader["ProductID"].ToString()));
                }
            }
        }

        private void BindProductList()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;

            string query = "SELECT ProductID, ProductName, Category, Brand, RAMCapacity, ROMCapacity, Price, Description, ImageUrl, QuantityInStock FROM Products";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptProducts.DataSource = dt;
                        rptProducts.DataBind();
                    }
                }
            }
        }

        private void CheckLowStock()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;
            string query = "SELECT ProductID, ProductName, QuantityInStock FROM Products";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable productsTable = new DataTable();
                        da.Fill(productsTable);

                        foreach (DataRow row in productsTable.Rows)
                        {
                            // Check for DBNull before conversion
                            if (row["QuantityInStock"] != DBNull.Value)
                            {
                                int quantityInStock = Convert.ToInt32(row["QuantityInStock"]);
                                if (quantityInStock < 20)
                                {
                                    // Alert the product that is in low stock
                                    string productName = row["ProductName"].ToString();
                                    string alertMessage = $"Alert: {productName} is running low on stock (Only {quantityInStock} left).";
                                    ClientScript.RegisterStartupScript(this.GetType(), "LowStockAlert", $"alert('{alertMessage}');", true);
                                }
                            }
                        }
                    }
                }
            }
        }

        protected void SendQuantity(object sender, EventArgs e)
        {
            string selectedProductId = ddlProduct.SelectedValue;
            int quantityToSend;

            if (int.TryParse(txtQuantity.Text, out quantityToSend) && quantityToSend > 0)
            {
                // Retrieve the available stock for the selected product
                string stockQuery = "SELECT QuantityInStock FROM Products WHERE ProductID = @ProductID";
                string updateQuery = "UPDATE Products SET QuantityInStock = QuantityInStock - @Quantity WHERE ProductID = @ProductID";
                string insertDispatchQuery = "INSERT INTO ProductDispatch (ProductID, QuantitySent, DispatchDate) VALUES (@ProductID, @QuantitySent, @DispatchDate)";

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["data"].ConnectionString))
                {
                    SqlCommand stockCmd = new SqlCommand(stockQuery, conn);
                    stockCmd.Parameters.AddWithValue("@ProductID", selectedProductId);

                    try
                    {
                        conn.Open();

                        // Retrieve the current stock quantity
                        object result = stockCmd.ExecuteScalar();
                        int currentStock = result != null ? Convert.ToInt32(result) : 0;

                        if (quantityToSend <= currentStock)
                        {
                            // Update stock quantity
                            SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                            updateCmd.Parameters.AddWithValue("@Quantity", quantityToSend);
                            updateCmd.Parameters.AddWithValue("@ProductID", selectedProductId);
                            int rowsAffected = updateCmd.ExecuteNonQuery();

                            // Insert dispatch details into ProductDispatch table
                            SqlCommand insertCmd = new SqlCommand(insertDispatchQuery, conn);
                            insertCmd.Parameters.AddWithValue("@ProductID", selectedProductId);
                            insertCmd.Parameters.AddWithValue("@QuantitySent", quantityToSend);
                            insertCmd.Parameters.AddWithValue("@DispatchDate", DateTime.Now); // Current timestamp

                            insertCmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                string script = "alert('Order sent successfully! Redirecting to product page...'); window.location='InventoryManagement.aspx';";
                                ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
                            }
                            else
                            {
                                lblMessage.Text = "Error: Product not found.";
                            }
                        }
                        else
                        {
                            lblMessage.Text = "Error: You cannot send more than the available stock.";
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error sending quantity: " + ex.Message;
                    }
                }
            }
            else
            {
                lblMessage.Text = "Please enter a valid quantity.";
            }
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                string productId = e.CommandArgument.ToString();
                DeleteProduct(productId);
            }
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddProduct.aspx");
        }

        private void DeleteProduct(string productId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;
            string deleteQuery = "DELETE FROM Products WHERE ProductID = @ProductID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(deleteQuery, conn);
                cmd.Parameters.AddWithValue("@ProductID", productId);
                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    lblMessage.Text = "Product deleted successfully!";
                }
                else
                {
                    lblMessage.Text = "Error: Product not found.";
                }
            }

            // Re-bind the product list to reflect the deletion
            BindProductList();
        }

    }
}
