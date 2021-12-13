using NKSLK.Entites;
using NKSLK.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Dao
{
    public class NhatKyDao
    {

        public static List<NKSLK_View> GetAllNhatKy(QLNC db)
        {
            var rs = (from nk in db.NKSLKs
                      join ds in db.DANHSACHCONGNHANs on nk.MaDanhSach equals ds.MaDanhSach
                      join cn in db.CONGNHANs on ds.MaCN equals cn.MaCN
                      orderby nk.NgayThucHien descending
                      select new NKSLK_View
                      {
                          MaNK = nk.ID,
                          MaTo = ds.MaTo,
                          MaCN = cn.MaCN,
                          HoTen = cn.HoTen,
                          NgaySinh = cn.NgaySinh,
                          GioiTinh = cn.GioiTinh,
                          NgayThucHien = nk.NgayThucHien,
                          GioBatDau = nk.GioBatDau,
                          GioKetThuc = nk.GioKetThuc
                      }).ToList();

            return rs;
        }

        public static List<NKSLK_View> Search(FormCollection collection, QLNC db)
        {
            var macn = collection["macn-search"];
            var mato = collection["mato-search"];
            var hoten = collection["hoten-search"];
            var ngaybatdau = collection["ngaybatdau-search"];
            var ngayketthuc = collection["ngayketthuc-search"];
            var maca = collection["maca-search"];

            int i_macn = -1;
            int i_mato = -1;
            DateTime? dt_ngaybatdau = null;
            DateTime? dt_ngayketthuc = null;
            int i_maca = -1;
            try
            {
                i_macn = int.Parse(macn);
            }
            catch { }
            try
            {
                i_mato = int.Parse(mato);
            }
            catch { }
            try
            {
                dt_ngaybatdau = DateTime.Parse(ngaybatdau);
                dt_ngayketthuc = DateTime.Parse(ngayketthuc);
            }
            catch { }
            try
            {
                i_maca = int.Parse(maca);
            }
            catch { }

            var rs = GetAllNhatKy(db);
            if (macn != "" && macn != null || mato != "" && mato != null || hoten != "" && hoten != null ||
                ngaybatdau != "" && ngaybatdau != null || ngayketthuc != "" && ngayketthuc != null || maca != "" && maca != null)
            {
                if (macn != "")
                    rs = (from nk in rs where nk.MaCN == i_macn select nk).ToList();
                if (hoten != "")
                    rs = (from nk in rs where nk.HoTen.Contains(hoten) select nk).ToList();
                if (mato != "")
                    rs = (from nk in rs where nk.MaTo == i_mato select nk).ToList();
                if (ngaybatdau != "")
                    rs = (from nk in rs where nk.NgayThucHien >= dt_ngaybatdau select nk).ToList();
                if (ngayketthuc != "")
                    rs = (from nk in rs where nk.NgayThucHien <= dt_ngayketthuc select nk).ToList();
                if (maca != "")
                {
                    rs = (from nk in rs
                          join ctcl in db.CHITIETCALAMs on nk.MaTo equals ctcl.MaTo where nk.NgayThucHien == ctcl.NgayThucHien
                          && ctcl.MaCa == i_maca
                          select nk).ToList();
                   
                }    
            }
            return rs;
        }


        public static List<NKSLK_View> HienThiDiemDanh(FormCollection collection, QLNC db)
        {

            var mato = collection["mato-diemdanh"];
            var ngaythuchien = collection["ngaythuchien-diemdanh"];

            int i_mato = -1;
            DateTime? dt_ngaythuchien = null;

            try
            {
                i_mato = int.Parse(mato);
            }
            catch { }
            try
            {
                dt_ngaythuchien = DateTime.Parse(ngaythuchien);
            }
            catch { }

            
            if (mato != "" && mato != null && ngaythuchien != "" && ngaythuchien != null)
            {
                var rs = (from nk in db.NKSLKs where nk.NgayThucHien == dt_ngaythuchien
                          join ds in db.DANHSACHCONGNHANs on nk.MaDanhSach equals ds.MaDanhSach where ds.MaTo == i_mato
                          join cn in db.CONGNHANs on ds.MaCN equals cn.MaCN
                          select new NKSLK_View
                          {
                              MaNK = nk.ID,
                              MaTo = ds.MaTo,
                              MaCN = cn.MaCN,
                              HoTen = cn.HoTen,
                              NgaySinh = cn.NgaySinh,
                              GioiTinh = cn.GioiTinh,
                              NgayThucHien = nk.NgayThucHien,
                              GioBatDau = nk.GioBatDau,
                              GioKetThuc = nk.GioKetThuc
                          }).ToList();
                return rs;
            }

            return null;
        }

    }
}