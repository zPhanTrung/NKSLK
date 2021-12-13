using NKSLK.Dao;
using NKSLK.Entites;
using NKSLK.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Controllers
{
    public class CongViecDaLamController : Controller
    {
        QLNC db = new QLNC();
        public ActionResult Index(int? id)
        {
            var ctCalam = db.CHITIETCALAMs.Find(id);
            ViewBag.MaChiTietCaLam = id;
            ViewBag.MaTo = ctCalam.MaTo;
            ViewBag.TenCa = db.CALAMVIECs.Find(ctCalam.MaCa).TenCa;
            ViewBag.NgayThucHien = ctCalam.NgayThucHien;
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            List<CongViecDaLam_View> cvDaLam = CongViecDaLamDao.GetAll(id, db);
            if (ctCalam == null)
            {
                return HttpNotFound();
            }
            return View(cvDaLam);
        }

        public ActionResult Create(FormCollection collection, int id)
        {

            var macv = collection["macv"];
            var masp = collection["masp"];
            var sanluong = collection["sanluong"];
            var solo = collection["solo"];
            int i_sanluong = 0;
            try
            {
                int i_macv = int.Parse(macv);
                if (sanluong != "")
                    i_sanluong = int.Parse(sanluong);
                var cvDaLam = new CONGVIECDALAM { MaCV = i_macv, MaSP = masp, SanLuong = i_sanluong, SoLo = solo, MaChiTietCaLam = id };
                db.CONGVIECDALAMs.Add(cvDaLam);
                db.SaveChanges();
                return RedirectPermanent("/CongViecDaLam/Index/" + id);
            }
            catch{}
            return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Edit([Bind(Include = "ID,MaCV,MaSP,SanLuong,SoLo")] CONGVIECDALAM cvDaLam)
        {
            var cvdl = db.CONGVIECDALAMs.Find(cvDaLam.ID);
            if (TryUpdateModel(cvdl, "",
                new string[] { "MaCV", "MaSP", "SanLuong", "SoLo" }))
            {
                try
                {
                    db.SaveChanges();
                    return RedirectPermanent("/CongViecDaLam/Index/" + cvdl.MaChiTietCaLam);
                }
                catch { }
            }
            return Json(new { alert = "fail" }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Details(int id)
        {
            var cvDaLam = db.CONGVIECDALAMs.Find(id);
            if (cvDaLam != null)
            {
                var congviec = (from cv in db.CONGVIECs
                                where cv.MaCV == cvDaLam.MaCV
                                select new
                                {
                                    cv.MaCV,
                                    cv.TenCV,
                                    cv.DinhMucKhoan,
                                    cv.DonViKhoan,
                                    cv.HeSoKhoan,
                                    cv.DinhMucLaoDong,
                                    cv.DonGia
                                }).First();
                var sanpham = (from sp in db.SANPHAMs
                          where sp.MaSP == cvDaLam.MaSP
                          select new
                          {
                              sp.MaSP,
                              sp.TenSP,
                              sp.SoDangKy,
                              sp.NgayDangKy,
                              sp.HanSuDung,
                              sp.QuyCach,
                              sp.Anh
                          }).First();
                string rs1 = Newtonsoft.Json.JsonConvert.SerializeObject(congviec);
                string rs2 = Newtonsoft.Json.JsonConvert.SerializeObject(sanpham);
                string result = "[" + rs1 + "," + rs2 + "]";
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            return Content("fail");
        }


        public ActionResult Delete(int? id, int? mactCaLam)
        {
            CONGVIECDALAM cvDalam = db.CONGVIECDALAMs.Find(id); 
            try
            {
                db.CONGVIECDALAMs.Remove(cvDalam);
                db.SaveChanges();
                return RedirectPermanent("/CongViecDaLam/Index/" + mactCaLam);
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