using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace TradeLiteAppServer
{    
    [ServiceContract]
    public interface IRestServiceImpl
    {
        [OperationContract]
        [WebInvoke(Method =  "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "findProduct/{name}")]
        string FindProduct(string name);

        [OperationContract]
        [WebInvoke(Method = "POST",
            UriTemplate = "/AddProduct?name={name}&size={size}&price={price}",
            //RequestFormat = WebMessageFormat.Json,
            //ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Bare)]
        void AddProduct(string name, string size, int price);
    }
}
