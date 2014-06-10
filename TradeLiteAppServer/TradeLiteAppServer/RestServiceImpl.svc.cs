using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using TradeLiteAppServer.Data;

namespace TradeLiteAppServer
{
  public class RestServiceImpl : IRestServiceImpl
  {
    //private const string ConnectionString = @"Data Source=(local);Initial Catalog=TradeLite;Uid=sa;Pwd=masterkey;";
    private const string ConnectionString = @"Data Source=(local); Initial Catalog=TradeLite; Integrated Security=SSPI;";
    private const string QueryString = @"
      SELECT 
        P.ID,
        PD.Name,
        P.Size,
        PD.Price
      FROM Product P 
        INNER JOIN ProductDictionary PD ON PD.ID = P.IDProduct 
        INNER JOIN Store S ON S.ID = P.IDStore
      WHERE 
        P.State = 0 AND
        PD.Name LIKE '%{0}%'";

    public string FindProduct(string name)
    {
      try
      {
        var productList = new List<Product>();
        using (var connection =
          new SqlConnection(ConnectionString))
        {
          var command = new SqlCommand(String.Format(QueryString, name), connection);
          connection.Open();
          var reader = command.ExecuteReader();

          while (reader.Read())
          {
            productList.Add(new Product
            {
              Id = int.Parse(reader["ID"].ToString()),
              Name = reader["Name"].ToString(),
              Price = int.Parse(reader["Price"].ToString()),
              Size = reader["Size"].ToString()
            });
          }
          reader.Close();
          return new JavaScriptSerializer().Serialize(productList);
        }
      }
      catch (Exception exception)
      {
        return exception.Message;
      }
    }

    private const string CMD_PROD_DICT_INS = "tl_InsProductDictionary";
    public void AddProduct(string name, string size, int price)
    {
        using (SqlConnection sqlConnection = new SqlConnection(ConnectionString))
        {
            using (SqlCommand command = new SqlCommand(CMD_PROD_DICT_INS, sqlConnection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Name", name);
                command.Parameters.AddWithValue("@Price", price);

                sqlConnection.Open();
                try
                {
                    command.ExecuteNonQuery();
                }
                finally
                {
                    sqlConnection.Close();
                }
            }
        }
    }
  }
}