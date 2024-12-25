using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace w2
{
    public partial class ProductList2 : Page
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
            // Connection string from web.config
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;

            // SQL query to get products
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

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                // Get the ProductID from the CommandArgument
                int productId = Convert.ToInt32(e.CommandArgument);

                // Redirect to the EditProduct.aspx page with ProductID as a query parameter
                Response.Redirect($"EditProduct1.aspx?ProductID2={productId}");
            }
        }
    }
}
