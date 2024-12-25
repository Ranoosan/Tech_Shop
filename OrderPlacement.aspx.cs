using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace w2
{
    public partial class OrderPlacement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initial load if needed
                LoadProducts(); // Load products based on the initial supplier selection (if applicable)
            }
        }

        protected void ddlSupplier_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadProducts(); // Load products based on the selected supplier
        }

        private void LoadProducts()
        {
            string selectedSupplier = ddlSupplier.SelectedValue;
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string query = string.Empty;
                    string productIDField = string.Empty;

                    if (selectedSupplier == "Supplier1")
                    {
                        query = "SELECT ProductID, ProductName FROM Products";
                        productIDField = "ProductID"; // For Supplier1, the product ID is "ProductID"
                    }
                    else if (selectedSupplier == "Supplier2")
                    {
                        query = "SELECT ProductID2, ProductName FROM Products2";
                        productIDField = "ProductID2"; // For Supplier2, the product ID is "ProductID2"
                    }

                    if (!string.IsNullOrEmpty(query))
                    {
                        SqlCommand cmd = new SqlCommand(query, conn);
                        SqlDataReader reader = cmd.ExecuteReader();

                        ddlProduct.Items.Clear(); // Clear existing items before adding
                        ddlProduct.Items.Add(new ListItem("Select a Product", "")); // Default option

                        while (reader.Read())
                        {
                            ListItem item = new ListItem(reader["ProductName"].ToString(), reader[productIDField].ToString());
                            ddlProduct.Items.Add(item);
                        }
                        reader.Close();
                    }
                    else
                    {
                        ddlProduct.Items.Clear();
                        ddlProduct.Items.Add(new ListItem("Select a Supplier first", ""));
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading products: " + ex.Message;
            }
        }


        protected void LoadProductDetails(object sender, EventArgs e)
        {
            // Handle product details loading after selection
            string selectedProductId = ddlProduct.SelectedValue;
            if (!string.IsNullOrEmpty(selectedProductId))
            {
                // Display further product details here, such as price, description, etc.
                lblMessage.Text = "Selected Product ID: " + selectedProductId;
            }
        }

        protected void PlaceOrder(object sender, EventArgs e)
        {
            string selectedProduct = ddlProduct.SelectedValue;
            string supplier = ddlSupplier.SelectedValue;
            string customerName = txtCustomerName.Text;
            string customerEmail = txtCustomerEmail.Text;
            int quantity;

            if (int.TryParse(txtQuantity.Text, out quantity) && quantity > 0 && !string.IsNullOrEmpty(selectedProduct))
            {
                bool productExists = false;
                string checkProductQuery = "";

                if (supplier == "Supplier1")
                {
                    checkProductQuery = "SELECT COUNT(*) FROM Products WHERE ProductID = @ProductID";
                }
                else if (supplier == "Supplier2")
                {
                    checkProductQuery = "SELECT COUNT(*) FROM Products2 WHERE ProductID2 = @ProductID2";
                }

                if (!string.IsNullOrEmpty(checkProductQuery))
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["data"].ConnectionString))
                    {
                        SqlCommand checkCmd = new SqlCommand(checkProductQuery, conn);

                        if (supplier == "Supplier1")
                        {
                            checkCmd.Parameters.AddWithValue("@ProductID", selectedProduct);
                        }
                        else if (supplier == "Supplier2")
                        {
                            checkCmd.Parameters.AddWithValue("@ProductID2", selectedProduct);
                        }

                        try
                        {
                            conn.Open();
                            int count = (int)checkCmd.ExecuteScalar();
                            productExists = (count > 0);
                            conn.Close();
                        }
                        catch (Exception ex)
                        {
                            lblMessage.Text = "Error checking product existence: " + ex.Message;
                            return;
                        }
                    }
                }

                if (productExists)
                {
                    // Adjust the INSERT query based on the supplier
                    string query = "";

                    if (supplier == "Supplier1")
                    {
                        query = "INSERT INTO Orders2 (ProductID, Quantity, Supplier, CustomerName, CustomerEmail) VALUES (@ProductID, @Quantity, @Supplier, @CustomerName, @CustomerEmail)";
                    }
                    else if (supplier == "Supplier2")
                    {
                        query = "INSERT INTO Orders2 (ProductID, Quantity, Supplier, CustomerName, CustomerEmail) VALUES (@ProductID2, @Quantity, @Supplier, @CustomerName, @CustomerEmail)";
                    }

                    try
                    {
                        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["data"].ConnectionString))
                        {
                            SqlCommand cmd = new SqlCommand(query, conn);

                            if (supplier == "Supplier1")
                            {
                                cmd.Parameters.AddWithValue("@ProductID", selectedProduct);
                            }
                            else if (supplier == "Supplier2")
                            {
                                cmd.Parameters.AddWithValue("@ProductID2", selectedProduct);
                            }

                            cmd.Parameters.AddWithValue("@Quantity", quantity);
                            cmd.Parameters.AddWithValue("@Supplier", supplier);
                            cmd.Parameters.AddWithValue("@CustomerName", customerName);
                            cmd.Parameters.AddWithValue("@CustomerEmail", customerEmail);

                            conn.Open();
                            cmd.ExecuteNonQuery();
                            conn.Close();

                            // Display alert and redirect using JavaScript
                            string script = "alert('Order placed successfully! Redirecting to home page...'); window.location='AdminPage.aspx';";
                            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error placing order: " + ex.Message;
                    }
                }
                else
                {
                    lblMessage.Text = "Selected product does not exist.";
                }
            }
            else
            {
                lblMessage.Text = "Please select a product and enter a valid quantity.";
            }
        }

    }
}