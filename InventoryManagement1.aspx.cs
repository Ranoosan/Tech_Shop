using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace w2
{
    public partial class InventoryManagement1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts(); // Load products into the dropdown
                BindProductList();
            }
        }

        private void LoadProducts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ProductID2, ProductName FROM Products2";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlProduct.Items.Clear();
                ddlProduct.Items.Add(new ListItem("Select a Product", ""));
                while (reader.Read())
                {
                    ddlProduct.Items.Add(new ListItem(reader["ProductName"].ToString(), reader["ProductID2"].ToString()));
                }
            }
        }

        private void BindProductList()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;
            string query = "SELECT ProductID2, ProductName, Category, Brand, RAMCapacity, ROMCapacity, Price, Description, ImageUrl, QuantityInStock FROM Products2";

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

        protected void SendQuantity(object sender, EventArgs e)
        {
            string selectedProductId = ddlProduct.SelectedValue;
            int quantityToSend;

            if (int.TryParse(txtQuantity.Text, out quantityToSend) && quantityToSend > 0)
            {
                // SQL queries for updating stock and inserting dispatch details
                string updateQuery = "UPDATE Products2 SET QuantityInStock = QuantityInStock - @Quantity WHERE ProductID2 = @ProductID";
                string insertDispatchQuery = "INSERT INTO ProductDispatch2 (ProductID2, QuantitySent, DispatchDate) VALUES (@ProductID, @QuantitySent, @DispatchDate)";

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["data"].ConnectionString))
                {
                    SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                    updateCmd.Parameters.AddWithValue("@Quantity", quantityToSend);
                    updateCmd.Parameters.AddWithValue("@ProductID", selectedProductId);

                    SqlCommand insertCmd = new SqlCommand(insertDispatchQuery, conn);
                    insertCmd.Parameters.AddWithValue("@ProductID", selectedProductId);
                    insertCmd.Parameters.AddWithValue("@QuantitySent", quantityToSend);
                    insertCmd.Parameters.AddWithValue("@DispatchDate", DateTime.Now);

                    try
                    {
                        conn.Open();

                        // Execute stock update command
                        int rowsAffected = updateCmd.ExecuteNonQuery();

                        // If stock updated successfully, insert dispatch details
                        if (rowsAffected > 0)
                        {
                            insertCmd.ExecuteNonQuery();
                            string script = "alert('Order sent successfully! Redirecting to product page...'); window.location='InventoryManagement1.aspx';";
                            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
                        }
                        else
                        {
                            lblMessage.Text = "Error: Product not found.";
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
            Response.Redirect("AddProduct2.aspx");
        }
       

        private void CheckLowStock()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;
            string query = "SELECT ProductID2, ProductName, QuantityInStock FROM Products2";

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

        private void DeleteProduct(string productId2)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;
            string deleteQuery = "DELETE FROM Products2 WHERE ProductID2 = @ProductID2";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(deleteQuery, conn);
                cmd.Parameters.AddWithValue("@ProductID2", productId2);
                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    lblMessage.Text = "Product deleted successfully!";
                    // Refresh the product list
                    BindProductList();
                }
                else
                {
                    lblMessage.Text = "Error: Product not found.";
                }
            }
        }

    }
}
