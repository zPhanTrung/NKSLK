using NKSLK.Dao;
using NKSLK.Entites;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Controllers
{
    public class LichLamViecController : Controller
    {
        QLNC db = new QLNC();
        public ActionResult Index(FormCollection collection, int Page = 1)
        {
            ViewBag.MaTo = collection["mato"];
            ViewBag.NgayBatDau = collection["ngaybatdau"];
            ViewBag.NgayKetThuc = collection["ngayketthuc"];

            ViewBag.CaLamViec = db.CALAMVIECs.ToList();

            var lich = LichLamViecDao.Search(collection, db);
            int lenght = lich.ToList().Count;
            if (lenght % 10 > 0)
                ViewBag.PageNumber = lenght / 10 + 1;
            else
                ViewBag.PageNumber = lenght / 10;
            ViewBag.CurrentPage = Page;
            var model = lich.ToList().Skip((Page - 1) * 10);
            model = model.Take(10);
            return View(model.ToList());
        }

        public ActionResult Create([Bind(Include = "MaTo, NgayThucHien, MaCa")] CHITIETCALAM ctCalam)
        {
            if (ModelState.IsValid)
            {
                db.CHITIETCALAMs.Add(ctCalam);
                LichLamViecDao.AddNKSLK(ctCalam.MaTo, ctCalam.NgayThucHien, db);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Edit([Bind(Include = "MaChiTietCaLam, MaTo, MaCa, NgayThucHien")] CHITIETCALAM ctCalam)
        {
            if (ModelState.IsValid)
            {
                db.Entry(ctCalam).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
        }


        public ActionResult Delete(int id)
        {
            CHITIETCALAM ctCalam = db.CHITIETCALAMs.Find(id);
            var ngaythuchien = DateTime.Parse(ctCalam.NgayThucHien.Value.ToShortDateString());

            var rs = (from ct in db.CHITIETCALAMs
                      join tocn in db.TOCONGNHANs on ct.MaTo equals tocn.MaTo where ct.NgayThucHien == ngaythuchien
                      join ds in db.DANHSACHCONGNHANs on tocn.MaTo equals ds.MaTo
                      join nk in db.NKSLKs on ds.MaDanhSach equals nk.MaDanhSach
                      where nk.NgayThucHien == ngaythuchien && nk.GioBatDau == null && nk.GioKetThuc == null
                      select nk).ToList();

            if (rs.Count != 0)
            {
                try
                {
                    var congviecdalam = db.CONGVIECDALAMs.Where(s => s.MaChiTietCaLam == ctCalam.MaChiTietCaLam).ToList();
                    rs.ForEach(s => db.NKSLKs.Remove(s));
                    congviecdalam.ForEach(s => db.CONGVIECDALAMs.Remove(s));
                    db.CHITIETCALAMs.Remove(ctCalam);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch{ }
            }
            return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
        }

        

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}