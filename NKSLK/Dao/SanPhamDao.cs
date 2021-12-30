using NKSLK.Entites;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Dao
{
    public class SanPhamDao
    {



        public static List<SANPHAM> Search(FormCollection collection, QLNC db)
        {
            var ngaydangky = collection["ngaydangky-search"];
            DateTime? dt_ngaydangky = null;
            try
            {
                dt_ngaydangky = DateTime.Parse(ngaydangky);
            }
            catch { }
            var rs = db.SANPHAMs.ToList();

            if(ngaydangky!=""&&ngaydangky!=null)
            {
                if (ngaydangky != "")
                    rs = (from sp in rs where sp.NgayDangKy <= dt_ngaydangky select sp).ToList();

            }

            return rs;
        }
    }
}