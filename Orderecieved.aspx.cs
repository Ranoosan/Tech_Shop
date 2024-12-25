using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace w2
{
    public partial class Orderecieved : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrderReceivedList(); // Load orders when the page loads
            }
        }

        private void BindOrderReceivedList()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["data"].ConnectionString;

            // SQL query to fetch aggregated data from both ProductDispatch and ProductDispatch2
            string query = @"
                SELECT Supplier, ProductName, SUM(QuantitySent) AS TotalQuantitySent, MAX(DispatchDate) AS LatestDispatchDate
                FROM (
                    SELECT 'Supplier1' AS Supplier, P.ProductName, PD.QuantitySent, PD.DispatchDate
                    FROM ProductDispatch PD
                    JOIN Products P ON PD.ProductID = P.ProductID
                    UNION ALL
                    SELECT 'Supplier2' AS Supplier, P2.ProductName, PD2.QuantitySent, PD2.DispatchDate
                    FROM ProductDispatch2 PD2
                    JOIN Products2 P2 ON PD2.ProductID2 = P2.ProductID2
                ) AS Combined
                GROUP BY Supplier, ProductName
                ORDER BY LatestDispatchDate DESC;
            ";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Bind the fetched data to the Repeater control
                        rptOrders.DataSource = dt;
                        rptOrders.DataBind();
                    }
                }
            }
        }
    }
}
