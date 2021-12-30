using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using NKSLK.Dao;
using NKSLK.Entites;

namespace NKSLK.Controllers
{
    public class SanPhamController : Controller
    {
        private QLNC db = new QLNC();

        // GET: SANPHAMs
        public ActionResult Index(FormCollection collection, int Page = 1)
        {
            ViewBag.NgayDangKy = collection["ngaydangky-search"];

            var rs = SanPhamDao.Search(collection, db);
            int lenght = rs.ToList().Count;
            if (lenght % 10 > 0)
                ViewBag.PageNumber = lenght / 10 + 1;
            else
                ViewBag.PageNumber = lenght / 10;
            ViewBag.CurrentPage = Page;
            var model = rs.ToList().Skip((Page - 1) * 10);
            model = model.Take(10);
            return View(model.ToList());
        }


        [HttpPost]
        public ActionResult Create([Bind(Include = "MaSP,TenSP,SoDangKy,NgayDangKy,HanSuDung,QuyCach")] SANPHAM sanpham)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.SANPHAMs.Add(sanpham);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch{}
            }

            return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Edit(string masp)
        {
            var sanpham = db.SANPHAMs.Find(masp);
            if (TryUpdateModel(sanpham, "",
                new string[] { "TenSP", "SoDangKy", "NgayDangKy", "HanSuDung", "QuyCach"}))
            {
                try
                {
                    db.SaveChanges();
                    return RedirectPermanent("/SanPham/Index");
                }
                catch { }
            }
            return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Delete(string id)
        {
            SANPHAM sanpham = db.SANPHAMs.Find(id);
            db.SANPHAMs.Remove(sanpham);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult GetSanPham(string id)
        {
            var sanpham = (from sp in db.SANPHAMs
                            where sp.MaSP == id
                            select new 
                            {
                                sp.MaSP,
                                sp.TenSP,
                                sp.SoDangKy,
                                sp.NgayDangKy,
                                sp.HanSuDung,
                                sp.QuyCach,
                                sp.Anh
                            }).FirstOrDefault();
            string rs = Newtonsoft.Json.JsonConvert.SerializeObject(sanpham);
            return Json(rs, JsonRequestBehavior.AllowGet);
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
