using NKSLK.Entites;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Dao
{
    public class CongViecDao
    {

        public static List<CONGVIEC> Search(FormCollection collection, QLNC db)
        {
            var luachon = collection["luachon"];
            List<CONGVIEC> congviecs = db.CONGVIECs.ToList();
            if(luachon == "1")
            {
                SqlConnection connection = (SqlConnection)db.Database.Connection;
                SqlCommand command = new SqlCommand("getCVNhieuNKSLK", connection);
                command.CommandType = CommandType.StoredProcedure;
                congviecs = new List<CONGVIEC>();

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        Type type = typeof(CONGVIEC);
                        CONGVIEC obj = (CONGVIEC)Activator.CreateInstance(type);
                        PropertyInfo[] properties = obj.GetType().GetProperties();

                        foreach (PropertyInfo property in properties)
                        {
                            try
                            {
                                var value = reader[property.Name];
                                if (value != null)
                                    property.SetValue(obj, Convert.ChangeType(value.ToString(), property.PropertyType));

                            }
                            catch { }
                        }
                        congviecs.Add(obj);
                    }
                    reader.Close();
                }
                catch { }

            }
            else if(luachon=="2")
            {
                var max = congviecs.Select(s => s.DonGia).Max();
                congviecs = (from cv in congviecs where cv.DonGia == max select cv).ToList();
            }
            else if(luachon=="3")
            {
                var min = congviecs.Select(s => s.DonGia).Min();
                congviecs = (from cv in congviecs where cv.DonGia == min select cv).ToList();
            }
            else if(luachon=="4")
            {
                var avg = congviecs.Select(s => s.DonGia).Average();
                congviecs = (from cv in congviecs where cv.DonGia <= avg select cv).ToList();
            }
            else if(luachon=="5")
            {
                var avg = congviecs.Select(s => s.DonGia).Average();
                congviecs = (from cv in congviecs where cv.DonGia >= avg select cv).ToList();
            }
            return congviecs;
        }

    }
}