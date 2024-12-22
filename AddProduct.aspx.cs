using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI.WebControls;

namespace w2
{
    public partial class AddProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Optionally populate categories and brands if needed
            }
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedCategory = ddlCategory.SelectedValue;
            ddlBrand.Items.Clear();
            ddlRAMCapacity.Items.Clear();
            ddlROMCapacity.Items.Clear();

            // Populate brands based on selected category
            if (selectedCategory == "Laptop")
            {
                ddlBrand.Items.Add(new ListItem("Dell", "Dell"));
                ddlBrand.Items.Add(new ListItem("HP", "HP"));
                ddlBrand.Items.Add(new ListItem("Lenovo", "Lenovo"));
                ddlBrand.Items.Add(new ListItem("Asus", "Asus"));

                // Populate RAM and ROM capacities for laptops
                ddlRAMCapacity.Items.Add(new ListItem("4 GB", "4 GB"));
                ddlRAMCapacity.Items.Add(new ListItem("8 GB", "8 GB"));
                ddlRAMCapacity.Items.Add(new ListItem("16 GB", "16 GB"));

                ddlROMCapacity.Items.Add(new ListItem("256 GB", "256 GB"));
                ddlROMCapacity.Items.Add(new ListItem("512 GB", "512 GB"));
                ddlROMCapacity.Items.Add(new ListItem("1 TB", "1 TB"));
            }
            else if (selectedCategory == "PC")
            {
                ddlBrand.Items.Add(new ListItem("Dell", "Dell"));
                ddlBrand.Items.Add(new ListItem("HP", "HP"));
                ddlBrand.Items.Add(new ListItem("Acer", "Acer"));
                ddlBrand.Items.Add(new ListItem("MSI", "MSI"));

                // Populate RAM and ROM capacities for PCs
                ddlRAMCapacity.Items.Add(new ListItem("8 GB", "8 GB"));
                ddlRAMCapacity.Items.Add(new ListItem("16 GB", "16 GB"));
                ddlRAMCapacity.Items.Add(new ListItem("32 GB", "32 GB"));

                ddlROMCapacity.Items.Add(new ListItem("512 GB", "512 GB"));
                ddlROMCapacity.Items.Add(new ListItem("1 TB", "1 TB"));
                ddlROMCapacity.Items.Add(new ListItem("2 TB", "2 TB"));
            }
            else if (selectedCategory == "Mobile")
            {
                ddlBrand.Items.Add(new ListItem("Samsung", "Samsung"));
                ddlBrand.Items.Add(new ListItem("Apple", "Apple"));
                ddlBrand.Items.Add(new ListItem("OnePlus", "OnePlus"));
                ddlBrand.Items.Add(new ListItem("Xiaomi", "Xiaomi"));

                // Populate RAM and ROM capacities for mobiles
                ddlRAMCapacity.Items.Add(new ListItem("4 GB", "4 GB"));
                ddlRAMCapacity.Items.Add(new ListItem("6 GB", "6 GB"));
                ddlRAMCapacity.Items.Add(new ListItem("8 GB", "8 GB"));

                ddlROMCapacity.Items.Add(new ListItem("64 GB", "64 GB"));
                ddlROMCapacity.Items.Add(new ListItem("128 GB", "128 GB"));
                ddlROMCapacity.Items.Add(new ListItem("256 GB", "256 GB"));
            }
            else
            {
                ddlBrand.Items.Add(new ListItem("Select Brand", ""));
                ddlRAMCapacity.Items.Add(new ListItem("Select RAM Capacity", ""));
                ddlROMCapacity.Items.Add(new ListItem("Select ROM Capacity", ""));
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;
            string productName = txtProductName.Text.Trim();
            string category = ddlCategory.SelectedValue; // Use dropdown value for category
            string brand = ddlBrand.SelectedValue; // Use dropdown value for brand
            string ramCapacity = ddlRAMCapacity.SelectedValue; // Use dropdown value for RAM capacity
            string romCapacity = ddlROMCapacity.SelectedValue; // Use dropdown value for ROM capacity
            decimal price = decimal.Parse(txtPrice.Text.Trim());
            string description = txtDescription.Text.Trim();

            string imageUrl = null;
            if (fuImage.HasFile)
            {
                string fileName = Path.GetFileName(fuImage.PostedFile.FileName);
                string directoryPath = Server.MapPath("~/Images/");

                // Check if the directory exists, if not, create it
                if (!Directory.Exists(directoryPath))
                {
                    Directory.CreateDirectory(directoryPath);
                }

                string filePath = Path.Combine(directoryPath, fileName);
                fuImage.SaveAs(filePath);
                imageUrl = "~/Images/" + fileName;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Products (ProductName, Category, Brand, RAMCapacity, ROMCapacity, Price, Description, ImageUrl) " +
                               "VALUES (@ProductName, @Category, @Brand, @RAMCapacity, @ROMCapacity, @Price, @Description, @ImageUrl)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProductName", productName);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@Brand", brand);
                cmd.Parameters.AddWithValue("@RAMCapacity", ramCapacity);
                cmd.Parameters.AddWithValue("@ROMCapacity", romCapacity);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@ImageUrl", imageUrl ?? (object)DBNull.Value);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            Response.Redirect("supplier1.aspx"); // Redirect to a page that lists products after adding
        }
    }
}
