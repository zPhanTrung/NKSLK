using NKSLK.Entites;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Controllers
{
    public class CaLamViecController : Controller
    {
        QLNC db = new QLNC();
        public ActionResult Index()
        {
            var model = db.CALAMVIECs.ToList();
            return View(model.ToList());
        }

        public ActionResult Create([Bind(Include = "TenCa, GioBatDau, GioKetThuc")] CALAMVIEC calamviec)
        {
            if (ModelState.IsValid)
            {
                db.CALAMVIECs.Add(calamviec);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Edit([Bind(Include = "MaCa, TenCa, GioBatDau, GioKetThuc")] CALAMVIEC calamviec)
        {
            if (ModelState.IsValid)
            {
                db.Entry(calamviec).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
        }


        public ActionResult Delete(int id)
        {
            CALAMVIEC calamviec = db.CALAMVIECs.Find(id);
            try
            {
                db.CALAMVIECs.Remove(calamviec);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
            }
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