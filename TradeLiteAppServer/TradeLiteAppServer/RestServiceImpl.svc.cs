using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using TradeLiteAppServer.Data;

namespace TradeLiteAppServer
{
  public class RestServiceImpl : IRestServiceImpl
  {
    private const string ConnectionString = @"Data Source=(local);Initial Catalog=TradeLite;Uid=sa;Pwd=masterkey;";
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
      string result;
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
          result = new JavaScriptSerializer().Serialize(productList);
        }
      }
      catch (Exception exception)
      {
        result = exception.Message;
      }

      return result;
    }
  }
}