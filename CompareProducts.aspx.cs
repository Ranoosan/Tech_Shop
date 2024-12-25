using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace w2
{
    public partial class CompareProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFilters();
                LoadProducts();
            }
        }

        protected void FilterProducts(object sender, EventArgs e)
        {
            LoadProducts();
        }

        private void LoadFilters()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Load Brands
                    SqlCommand cmdBrands = new SqlCommand("SELECT DISTINCT Brand FROM Products", conn);
                    SqlDataReader readerBrands = cmdBrands.ExecuteReader();
                    ddlBrand.Items.Clear();
                    ddlBrand.Items.Add(new ListItem("All Brands", ""));
                    while (readerBrands.Read())
                    {
                        ddlBrand.Items.Add(new ListItem(readerBrands["Brand"].ToString(), readerBrands["Brand"].ToString()));
                    }
                    readerBrands.Close();

                    // Load RAM Capacities
                    SqlCommand cmdRAM = new SqlCommand("SELECT DISTINCT RAMCapacity FROM Products", conn);
                    SqlDataReader readerRAM = cmdRAM.ExecuteReader();
                    ddlRAMCapacity.Items.Clear();
                    ddlRAMCapacity.Items.Add(new ListItem("All RAM Capacities", ""));
                    while (readerRAM.Read())
                    {
                        ddlRAMCapacity.Items.Add(new ListItem(readerRAM["RAMCapacity"].ToString(), readerRAM["RAMCapacity"].ToString()));
                    }
                    readerRAM.Close();

                    // Load ROM Capacities
                    SqlCommand cmdROM = new SqlCommand("SELECT DISTINCT ROMCapacity FROM Products", conn);
                    SqlDataReader readerROM = cmdROM.ExecuteReader();
                    ddlROMCapacity.Items.Clear();
                    ddlROMCapacity.Items.Add(new ListItem("All ROM Capacities", ""));
                    while (readerROM.Read())
                    {
                        ddlROMCapacity.Items.Add(new ListItem(readerROM["ROMCapacity"].ToString(), readerROM["ROMCapacity"].ToString()));
                    }
                    readerROM.Close();
                }
            }
            catch (Exception ex)
            {
                // Handle or log the error
                // For example: Display a message to the user
                lblMessage.Text = "Error loading filters: " + ex.Message;
            }
        }

        private void LoadProducts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;
            string category = ddlCategory.SelectedValue;
            string brand = ddlBrand.SelectedValue;
            string ramCapacity = ddlRAMCapacity.SelectedValue;
            string romCapacity = ddlROMCapacity.SelectedValue;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Get products from 'Products' table for Supplier 1
                    string query1 = "SELECT * FROM Products WHERE (Category = @Category OR @Category = '') AND (Brand = @Brand OR @Brand = '') AND (RAMCapacity = @RAMCapacity OR @RAMCapacity = '') AND (ROMCapacity = @ROMCapacity OR @ROMCapacity = '')";
                    SqlCommand cmd1 = new SqlCommand(query1, conn);
                    cmd1.Parameters.AddWithValue("@Category", category);
                    cmd1.Parameters.AddWithValue("@Brand", brand);
                    cmd1.Parameters.AddWithValue("@RAMCapacity", ramCapacity);
                    cmd1.Parameters.AddWithValue("@ROMCapacity", romCapacity);

                    SqlDataReader reader1 = cmd1.ExecuteReader();

                    // Display Supplier 1 products
                    Supplier1Products.Controls.Clear();
                    while (reader1.Read())
                    {
                        string productHtml = $@"
                            <div class='product-card'>
                                <img src='{reader1["ImageUrl"]}' alt='{reader1["ProductName"]}' />
                                <h3>{reader1["ProductName"]}</h3>
                                <p><strong>Category:</strong> {reader1["Category"]}</p>
                                <p><strong>Brand:</strong> {reader1["Brand"]}</p>
                                <p><strong>RAM:</strong> {reader1["RAMCapacity"]}</p>
                                <p><strong>ROM:</strong> {reader1["ROMCapacity"]}</p>
                                <p class='price'>${reader1["Price"]}</p>
                                <p>{reader1["Description"]}</p>
                            </div>";
                        Supplier1Products.Controls.Add(new Literal { Text = productHtml });
                    }

                    reader1.Close();

                    // Get products from 'Products2' table for Supplier 2
                    string query2 = "SELECT * FROM Products2 WHERE (Category = @Category OR @Category = '') AND (Brand = @Brand OR @Brand = '') AND (RAMCapacity = @RAMCapacity OR @RAMCapacity = '') AND (ROMCapacity = @ROMCapacity OR @ROMCapacity = '')";
                    SqlCommand cmd2 = new SqlCommand(query2, conn);
                    cmd2.Parameters.AddWithValue("@Category", category);
                    cmd2.Parameters.AddWithValue("@Brand", brand);
                    cmd2.Parameters.AddWithValue("@RAMCapacity", ramCapacity);
                    cmd2.Parameters.AddWithValue("@ROMCapacity", romCapacity);

                    SqlDataReader reader2 = cmd2.ExecuteReader();

                    // Display Supplier 2 products
                    Supplier2Products.Controls.Clear();
                    while (reader2.Read())
                    {
                        string productHtml = $@"
                            <div class='product-card'>
                                <img src='{reader2["ImageUrl"]}' alt='{reader2["ProductName"]}' />
                                <h3>{reader2["ProductName"]}</h3>
                                <p><strong>Category:</strong> {reader2["Category"]}</p>
                                <p><strong>Brand:</strong> {reader2["Brand"]}</p>
                                <p><strong>RAM:</strong> {reader2["RAMCapacity"]}</p>
                                <p><strong>ROM:</strong> {reader2["ROMCapacity"]}</p>
                                <p class='price'>${reader2["Price"]}</p>
                                <p>{reader2["Description"]}</p>
                            </div>";
                        Supplier2Products.Controls.Add(new Literal { Text = productHtml });
                    }

                    reader2.Close();
                }
            }
            catch (Exception ex)
            {
                // Handle or log the error
                // For example: Display a message to the user
                lblMessage.Text = "Error loading products: " + ex.Message;
            }
        }
        protected void PlaceOrder_Click(object sender, EventArgs e)
        {
            string selectedProductId = ddlOrderProducts.SelectedValue;
            int quantity;
            if (int.TryParse(txtQuantity.Text, out quantity) && quantity > 0)
            {
                // Insert order details into the database
                string connectionString = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO Orders (ProductID, Quantity, OrderDate) VALUES (@ProductID, @Quantity, @OrderDate)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ProductID", selectedProductId);
                    cmd.Parameters.AddWithValue("@Quantity", quantity);
                    cmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

                // Optionally show a success message
                Response.Write("<script>alert('Order placed successfully!');</script>");
            }
            else
            {
                // Optionally show an error message
                Response.Write("<script>alert('Please enter a valid quantity.');</script>");
            }
        }
    }
}
