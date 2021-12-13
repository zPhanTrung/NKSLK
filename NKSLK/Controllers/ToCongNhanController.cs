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
    public class ToCongNhanController : Controller
    {
        private QLNC db = new QLNC();

        public ActionResult Index(FormCollection collection, int Page = 1)
        {
            ViewBag.MaTo = collection["maTo"];
            var rs = ToCongNhanDao.SearchToCongNhan(collection, db);
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
            TOCONGNHAN toCN = db.TOCONGNHANs.Find(id);
            if (toCN == null)
            {
                return HttpNotFound();
            }
            return View(toCN);
        }

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            var date = collection["ngaytao"];
            var toCN = new TOCONGNHAN();
            toCN.NgayTao = DateTime.Parse(date);
            toCN.SoLuong = 0;
            db.TOCONGNHANs.Add(toCN);
            db.SaveChanges();
            return RedirectPermanent("/ToCongNhan/Edit/" + toCN.MaTo);
        }

 
        public ActionResult Edit(FormCollection collection, int id, int Page = 1)
        {
            ViewBag.MaCN = collection["macn-search"];
            ViewBag.HoTen = collection["hoten-search"];
            
            var toCN = db.TOCONGNHANs.Find(id);
            ViewBag.MaTo = toCN.MaTo;
            ViewBag.NgayTao = toCN.NgayTao;
            ViewBag.SoLuong = toCN.SoLuong;
            List<CONGNHAN> rs;
            if (collection["mato-search"]==null)
            {
                rs = (from ds in db.DANHSACHCONGNHANs
                                     join cn in db.CONGNHANs on ds.MaCN equals cn.MaCN
                                     where ds.MaTo == id
                                     select cn).ToList();
            }
            else
                rs = ToCongNhanDao.SearchCongNhan(collection, db);
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
        public ActionResult Add(int id, int macn)
        {
            var tocn = db.TOCONGNHANs.Find(id);
            if (tocn != null)
            {
                var danhsach = new DANHSACHCONGNHAN();
                danhsach.MaCN = macn;
                danhsach.MaTo = id;
                db.DANHSACHCONGNHANs.Add(danhsach);
                tocn.SoLuong += 1;
                db.SaveChanges();
            }
            return RedirectPermanent("/ToCongNhan/Edit/" + id);
        }

        

        [HttpPost]
        public ActionResult Remove(int id, int mato)
        {
            var tocn = db.TOCONGNHANs.Find(mato);
            var congnhan = db.DANHSACHCONGNHANs.Where(s => s.MaCN == id && s.MaTo == mato).First();
            db.DANHSACHCONGNHANs.Remove(congnhan);
            tocn.SoLuong -= 1;
            db.SaveChanges();
            return RedirectPermanent("/ToCongNhan/Edit/" + mato);
        }

        [HttpPost]
        public ActionResult Delete(int id)
        {
            var tocn = db.TOCONGNHANs.Find(id);
            var dscn = db.DANHSACHCONGNHANs.Where(s => s.MaTo == id).ToList();
            dscn.ForEach(s => db.DANHSACHCONGNHANs.Remove(s));

            if (tocn != null)
            {
                try
                {
                    db.TOCONGNHANs.Remove(tocn);
                    db.SaveChanges();
                }
                catch { }
            }
            return RedirectToAction("Index");
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