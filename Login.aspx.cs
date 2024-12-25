using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace w2
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Get the username and password from the text boxes
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Connection string (replace with your actual SQL Server connection string)
            string connectionString = "Data Source=PC-POPS-04\\SQLEXPRESS;Initial Catalog=SupplierAdminDB;Integrated Security=True";

            // Query to get the user role based on the provided username and password
            string query = "SELECT Role FROM Users WHERE Username=@Username AND Password=@Password";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    // Add parameters to prevent SQL injection
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);

                    con.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        // Login successful, get the user role
                        string role = result.ToString();
                        Session["Username"] = username;
                        Session["Role"] = role;

                        // Redirect based on role
                        if (role == "Admin")
                        {
                            Response.Redirect("AdminPage.aspx");
                        }
                        if (role == "Supplier1")
                        {
                            Response.Redirect("supplier1.aspx");
                        }
                        if (role == "Supplier2")
                        {
                            Response.Redirect("supplier2.aspx");
                        }
                        
                    }
                    else
                    {
                        // Login failed
                        lblMessage.Text = "Invalid username or password.";
                    }

                    con.Close();
                }
            }
        }
    }
}
