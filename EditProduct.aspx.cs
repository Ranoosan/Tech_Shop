using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI.WebControls;

public partial class EditProduct : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) 
        {
            // Check if ProductID exists in the query string
            if (Request.QueryString["ProductID"] != null)
            {
                int productId;
                // Try parsing ProductID and load product details
                if (int.TryParse(Request.QueryString["ProductID"], out productId))
                {
                    LoadProductDetails(productId);
                }
                else
                {
                    lblMessage.Text = "Invalid Product ID.";
                }
            }
            else
            {
                lblMessage.Text = "Product ID is missing.";
            }
        }
    }

    private void LoadProductDetails(int productId)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;
        string query = "SELECT ProductName, Category, Brand, RAMCapacity, ROMCapacity, Price, Description, ImageUrl, QuantityInStock FROM Products WHERE ProductID = @ProductID";

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@ProductID", productId);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                // Load the product details into the form fields
                txtProductName.Text = reader["ProductName"].ToString();
                txtCategory.Text = reader["Category"].ToString();
                txtBrand.Text = reader["Brand"].ToString();
                txtRAMCapacity.Text = reader["RAMCapacity"].ToString();
                txtROMCapacity.Text = reader["ROMCapacity"].ToString();
                txtPrice.Text = reader["Price"].ToString();
                txtQuantity.Text = reader["QuantityInStock"].ToString();
                txtDescription.Text = reader["Description"].ToString();

                imgProduct.ImageUrl = reader["ImageUrl"].ToString();
            }
            else
            {
                lblMessage.Text = "Product not found.";
            }
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        int productId = int.Parse(Request.QueryString["ProductID"]);
        string productName = txtProductName.Text;
        string category = txtCategory.Text;
        string brand = txtBrand.Text;
        string ramCapacity = txtRAMCapacity.Text;
        string romCapacity = txtROMCapacity.Text;
        decimal price = decimal.Parse(txtPrice.Text);
        string description = txtDescription.Text;
        decimal QuantityInStock = decimal.Parse(txtQuantity.Text);
        string imageUrl = imgProduct.ImageUrl;

        if (fileUpload.HasFile)
        {
            string fileName = Path.GetFileName(fileUpload.PostedFile.FileName);
            string filePath = "~/ProductImages/" + fileName;
            fileUpload.SaveAs(Server.MapPath(filePath));
            imageUrl = filePath;
        }

        string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;
        string query = "UPDATE Products SET ProductName = @ProductName, Category = @Category, Brand = @Brand, RAMCapacity = @RAMCapacity, ROMCapacity = @ROMCapacity, Price = @Price, Description = @Description, ImageUrl = @ImageUrl, QuantityInStock = @QuantityInStock WHERE ProductID = @ProductID";

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@ProductName", productName);
            cmd.Parameters.AddWithValue("@Category", category);
            cmd.Parameters.AddWithValue("@Brand", brand);
            cmd.Parameters.AddWithValue("@RAMCapacity", ramCapacity);
            cmd.Parameters.AddWithValue("@ROMCapacity", romCapacity);
            cmd.Parameters.AddWithValue("@Price", price);
            cmd.Parameters.AddWithValue("@QuantityInStock", QuantityInStock);
            cmd.Parameters.AddWithValue("@Description", description);
            cmd.Parameters.AddWithValue("@ImageUrl", imageUrl);
            cmd.Parameters.AddWithValue("@ProductID", productId);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        string script = "alert('Order placed successfully! Redirecting to product page...'); window.location='ProductList1.aspx';";
        ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
    }
}
