using NKSLK.Entites;
using NKSLK.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Dao
{
    public class CongNhanDao
    {
        public static List<CONGNHAN> FindByMaTo(int? maTo, QLNC db)
        {
            var result = (from cn in db.CONGNHANs
                          join ds in db.DANHSACHCONGNHANs on cn.MaCN equals ds.MaCN
                          join to in db.TOCONGNHANs on ds.MaTo equals to.MaTo
                          where to.MaTo == maTo
                          select cn).ToList();
            return result;
        }

        public static List<CONGNHAN> Search(FormCollection collection, QLNC db)
        {
            var maCN = collection["maCN"];
            var maTo = collection["mato"];
            var hoten = collection["hoten"];
            var phongban = collection["phongban"];
            var dotuoi1 = collection["dotuoi1"];
            var dotuoi2 = collection["dotuoi2"];

            
            int i_maCN = -1;
            int i_maTo = -1;
            int i_dotuoi1 = -1;
            int i_dotuoi2 = -1;

            try
            {
                i_maCN = int.Parse(maCN);
                i_maTo = int.Parse(maTo);
            }
            catch{}

            try
            {
                i_dotuoi1 = int.Parse(dotuoi1);
                i_dotuoi2 = int.Parse(dotuoi2);
            }
            catch { }
            List<CONGNHAN> rs = db.CONGNHANs.ToList();

            if (maCN != null && maTo != null && hoten != null && phongban != null && dotuoi1 != null && dotuoi2 != null)
                if (maCN != "" || maTo != "" || hoten != "" || phongban != "" || dotuoi1 != "" && dotuoi2 != "")
                {
                    if (maCN != "")
                    {
                        rs = (from cn in db.CONGNHANs where cn.MaCN == i_maCN select cn).ToList();
                    }
                    if (maTo != "")
                    {
                        rs = (from cn in rs
                              join ds in db.DANHSACHCONGNHANs on cn.MaCN equals ds.MaCN
                              where ds.MaTo == i_maTo
                              select cn).ToList();
                    }
                    if (hoten != "")
                        rs = (from cn in rs where cn.HoTen.Contains(hoten) select cn).ToList();
                    if (phongban != "")
                        rs = (from cn in rs where cn.PhongBan.Contains(phongban) select cn).ToList();
                    if (dotuoi1 != "" && dotuoi2 != "")
                    {
                        DateTime date1 = DateTime.Now.AddYears(-i_dotuoi1);
                        DateTime date2 = DateTime.Now.AddYears(-i_dotuoi2);
                        rs = (from cn in rs where cn.NgaySinh >= date2 && cn.NgaySinh <= date1 select cn).ToList();
                    }
                        

                }

            return rs;
        }
    }

   
}