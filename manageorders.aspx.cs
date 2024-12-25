using System;

namespace w2
{
    public partial class manageorders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optional: Add any code here if needed during page load.
        }

        // Redirect to the Order Received page when the first button is clicked
        protected void btnOrderReceived_Click(object sender, EventArgs e)
        {
            Response.Redirect("Orderecieved.aspx"); // Adjust the filename if needed
        }

        // Redirect to the Add Product page when the second button is clicked
        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("OrderPlacement.aspx"); // Adjust the filename if needed
        }
        protected void btnViewProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewOrders.aspx"); // Adjust the filename if needed
        }
    }
}
