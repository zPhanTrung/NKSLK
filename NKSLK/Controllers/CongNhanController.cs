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
    public class CongNhanController : Controller
    {
        private QLNC db = new QLNC();

        // GET: CONGNHANs
        public ActionResult Index(FormCollection collection, int Page = 1)
        {
            ViewBag.MaCN = collection["macn"];
            ViewBag.MaTo = collection["mato"];
            ViewBag.HoTen = collection["hoten"];
            ViewBag.PhongBan = collection["phongban"];
            ViewBag.DoTuoi1 = collection["dotuoi1"];
            ViewBag.DoTuoi2 = collection["dotuoi2"];
            var rs = CongNhanDao.Search(collection, db);
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
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CONGNHAN congNhan = db.CONGNHANs.Find(id);
            if (congNhan == null)
            {
                return HttpNotFound();
            }
            return View(congNhan);
        }


        [HttpPost]
        public ActionResult Create([Bind(Include = "HoTen,NgaySinh,GioiTinh,PhongBan,ChucVu,QueQuan,LuongHopDong,LuongBaoHiem")] CONGNHAN congNhan)
        {
            if (ModelState.IsValid)
            {
                db.CONGNHANs.Add(congNhan);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CONGNHAN congNhan = db.CONGNHANs.Find(id);
            if (congNhan == null)
            {
                return HttpNotFound();
            }

            return View(congNhan);
        }

        [HttpPost]
        public ActionResult Edit(int macn)
        {
            var congnhan = db.CONGNHANs.Find(macn);
            if (TryUpdateModel(congnhan, "",
                new string[] { "HoTen", "NgaySinh", "GioiTinh", "PhongBan", "ChucVu", "QueQuan", "LuongHopDong", "LuongBaoHiem" }))
            {
                try
                {
                    db.SaveChanges();
                    return RedirectPermanent("/CongNhan/Index");
                }
                catch { }
            }
            return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public ActionResult Delete(int id)
        {
            CONGNHAN congNhan = db.CONGNHANs.Find(id);
            db.CONGNHANs.Remove(congNhan);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        

        public ActionResult GetCongNhan(int id)
        {
            var congnhan = (from cn in db.CONGNHANs
                           where cn.MaCN==id
                           select new { cn.HoTen, cn.NgaySinh, cn.GioiTinh, cn.PhongBan, cn.ChucVu}).FirstOrDefault();
            string rs = Newtonsoft.Json.JsonConvert.SerializeObject(congnhan);
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