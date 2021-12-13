using NKSLK.Entites;
using NKSLK.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NKSLK.Dao
{
    public class CongViecDaLamDao
    {

        public static List<CongViecDaLam_View> GetAll(int? maCtCaLam, QLNC db)
        {
            var result = (from ct in db.CHITIETCALAMs
                          join cvdl in db.CONGVIECDALAMs on ct.MaChiTietCaLam equals cvdl.MaChiTietCaLam
                          where ct.MaChiTietCaLam == maCtCaLam
                          join cv in db.CONGVIECs on cvdl.MaCV equals cv.MaCV
                          join sp in db.SANPHAMs on cvdl.MaSP equals sp.MaSP
                          select new CongViecDaLam_View
                          {
                              MaCVDaLam=cvdl.ID,
                              MaCV = cv.MaCV,
                              TenCV = cv.TenCV,
                              MaSP = sp.MaSP,
                              TenSP = sp.TenSP,
                              SanLuong = cvdl.SanLuong,
                              SoLo = cvdl.SoLo
                          }).ToList();

            return result;
        }


    }
}