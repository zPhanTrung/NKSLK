using NKSLK.Entites;
using NKSLK.Models;
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
    public class ThongKeDao
    {
        public static List<LuongSanPham_CongNhan_View> LuongSanPham(FormCollection collection, QLNC db)
        {
            var ngaybatdau = collection["ngaybatdau-search-1"];
            var ngayketthuc = collection["ngayketthuc-search-1"];

            SqlConnection connection = (SqlConnection)db.Database.Connection;
            SqlCommand command = new SqlCommand("getLuongCN", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@firstDay", ngaybatdau);
            command.Parameters.AddWithValue("@lastDay", ngayketthuc);
            List<LuongSanPham_CongNhan_View>  luongsp = new List<LuongSanPham_CongNhan_View>();
            try
            {
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Type type = typeof(LuongSanPham_CongNhan_View);
                    LuongSanPham_CongNhan_View obj = (LuongSanPham_CongNhan_View)Activator.CreateInstance(type);
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
                    luongsp.Add(obj);
                }
                reader.Close();
            }
            catch { }

            return luongsp;
        }


        public static List<NgayCongDiLam_CongNhan_View> NgayCongDiLam(FormCollection collection, QLNC db)
        {
            var macn = collection["macn-search"];
            var ngaybatdau = collection["ngaybatdau-search-2"];
            var ngayketthuc = collection["ngayketthuc-search-2"];
            int i_macn = -1;
            try
            {
                i_macn = int.Parse(macn);
            }
            catch{}

            SqlConnection connection = (SqlConnection)db.Database.Connection;
            SqlCommand command = new SqlCommand("getSoNgayCong", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@MaCN", i_macn);
            command.Parameters.AddWithValue("@firstDay", ngaybatdau);
            command.Parameters.AddWithValue("@lastDay", ngayketthuc);
            List<NgayCongDiLam_CongNhan_View> ngaycong = new List<NgayCongDiLam_CongNhan_View>();
            try
            {
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    Type type = typeof(NgayCongDiLam_CongNhan_View);
                    NgayCongDiLam_CongNhan_View obj = (NgayCongDiLam_CongNhan_View)Activator.CreateInstance(type);
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
                    ngaycong.Add(obj);
                }
                reader.Close();
            }
            catch { }

            return ngaycong;
        }

    }
}