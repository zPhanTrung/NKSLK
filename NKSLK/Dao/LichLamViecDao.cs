using NKSLK.Entites;
using NKSLK.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Dao
{
    public class LichLamViecDao
    {
        public static List<LichLamViec_View> GetAllLichLamViec(QLNC db)
        {
            var rs = (from clv in db.CALAMVIECs
                      join ct in db.CHITIETCALAMs on clv.MaCa equals ct.MaCa
                      join tocn in db.TOCONGNHANs on ct.MaTo equals tocn.MaTo
                      select new LichLamViec_View
                      {
                          MaChiTietCaLam = ct.MaChiTietCaLam,
                          MaTo = ct.MaTo,
                          NgayThucHien = ct.NgayThucHien,
                          MaCa = clv.MaCa,
                          CaLamViec = clv.TenCa,
                          GioBatDau = clv.GioBatDau,
                          GioKetThuc = clv.GioKetThuc
                      }).ToList();

            return rs;
        }

        public static List<LichLamViec_View> Search(FormCollection collection, QLNC db)
        {
            var mato = collection["mato"];
            var ngaybatdau = collection["ngaybatdau"];
            var ngayketthuc = collection["ngayketthuc"];
            int i_mato = -1;
            DateTime? dt_ngaybatdau = null;
            DateTime? dt_ngayketthuc = null;
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

            var rs = GetAllLichLamViec(db);

            if ((mato != "" && mato != null) || ((ngaybatdau != "" && ngayketthuc != "") && (ngaybatdau != "" && ngayketthuc != null)))
            {
                if (mato != "")
                    rs = (from lich in rs where lich.MaTo == i_mato select lich).ToList();
                if (ngaybatdau != "" && ngayketthuc != "")
                    rs = (from lich in rs
                          where lich.NgayThucHien >= dt_ngaybatdau && lich.NgayThucHien <= dt_ngayketthuc
                          select lich).ToList();

            }

            return rs;
        }

        public static void AddNKSLK(int? mato, DateTime? ngaythuchien, QLNC db)
        {
            var rs = db.DANHSACHCONGNHANs.Where(s => s.MaTo == mato).ToList();
            rs.ForEach(s => db.NKSLKs.Add(new Entites.NKSLK { NgayThucHien = ngaythuchien, MaDanhSach = s.MaDanhSach }));
        }

    }
}