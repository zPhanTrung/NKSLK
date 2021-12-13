using NKSLK.Dao;
using NKSLK.Entites;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Controllers
{
    public class CongViecController : Controller
    {
        QLNC db = new QLNC();
        public ActionResult Index(FormCollection collection, int Page = 1)
        {
            ViewBag.LuaChon = collection["luachon"];

            var rs = CongViecDao.Search(collection, db);
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
        public ActionResult Create([Bind(Include = "MaCV,TenCV,DinhMucKhoan,DonViKhoan,HeSoKhoan,DinhMucLaoDong,DonGia")] CONGVIEC congviec)
        {
            if (ModelState.IsValid)
            {
                db.CONGVIECs.Add(congviec);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Edit(int id)
        {
            var congviec = db.CONGVIECs.Find(id);
            if (TryUpdateModel(congviec, "",
                new string[] { "TenCV", "DinhMucKhoan", "DonViKhoan", "HeSoKhoan", "DinhMucLaoDong", "DonGia" }))
            {
                try
                {
                    db.SaveChanges();
                    return RedirectPermanent("/CongViec/Index");
                }
                catch { }
            }
            return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Delete(int id)
        {
            CONGVIEC congviec = db.CONGVIECs.Find(id);
            db.CONGVIECs.Remove(congviec);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult GetCongViec(int id)
        {
            var conviec = (from cv in db.CONGVIECs
                            where cv.MaCV == id
                            select new 
                            {
                                cv.MaCV,
                                cv.TenCV,
                                cv.DinhMucKhoan,
                                cv.DonViKhoan,
                                cv.HeSoKhoan,
                                cv.DinhMucLaoDong,
                                cv.DonGia
                            }).FirstOrDefault();
            string rs = Newtonsoft.Json.JsonConvert.SerializeObject(conviec);
            return Json(rs, JsonRequestBehavior.AllowGet);
        }
    }
}