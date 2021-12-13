using NKSLK.Entites;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Dao
{
    public class ToCongNhanDao
    {

        public static List<TOCONGNHAN> SearchToCongNhan(FormCollection collection, QLNC db)
        {
            var mato = collection["maTo"];
            int i_mato = -1;
            List<TOCONGNHAN> rs = db.TOCONGNHANs.ToList();
            try
            {
                i_mato = int.Parse(mato);
            }
            catch{}

            if (mato != "" && mato != null)
            {
                rs = (from tocn in rs
                      where tocn.MaTo == i_mato
                      select tocn).ToList();
            }

            return rs;
        }

        public static List<CONGNHAN> SearchCongNhan(FormCollection collection, QLNC db)
        {
            var macn = collection["macn-search"];
            var hoten = collection["hoten-search"];
            var mato = collection["mato-search"];
            int i_macn = -1;
            int i_mato = -1;
            try
            {
                i_mato = int.Parse(mato);
                i_macn = int.Parse(macn);
            }
            catch { }

            List<CONGNHAN> rs = (from ds in db.DANHSACHCONGNHANs
                                join cn in db.CONGNHANs on ds.MaCN equals cn.MaCN
                                where ds.MaTo == i_mato
                                select cn).ToList();

            if (macn != "" && macn != null || hoten != "" && hoten != null)
            {
                if(macn!="")
                {
                    rs = (from cn in rs
                          where cn.MaCN == i_macn
                          select cn).ToList();
                }
                if(hoten!="")
                {
                    rs = (from cn in rs
                          where cn.HoTen.Contains(hoten)
                          select cn).ToList();
                }
            }

            return rs;
        }
    }
}